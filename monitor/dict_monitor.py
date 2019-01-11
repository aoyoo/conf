#coding=gb2312
import os
import re
import sys
import json
import time
import smtplib
import logging
import datetime
import subprocess
import ConfigParser
import requests

import log

from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

from tabulate import tabulate

reload(sys)
sys.setdefaultencoding('gb2312')

conf = ConfigParser.ConfigParser()    
conf.read('conf')   

mail_from = conf.get('basic', 'mail_from')
print 'mail_from', mail_from

mail_to = conf.get('basic', 'mail_to')
mail_to = [s.strip(' ') for s in mail_to.split(',')]
print 'mail_to', mail_to

phone_to = conf.get('basic', 'phone_to')
phone_to = [s.strip(' ') for s in phone_to.split(',')]
print 'phone_to', phone_to

dns_name = conf.get('basic', 'dns')
server_name = dns_name

monitor_list = conf.items('monitor_files')
monitor_files = {}
for f in monitor_list:
    monitor_files[f[0]] = int(f[1])
print monitor_files
    
OK = 0
NOT_EXIST = 1
UNKOWN = 2

def send_sms(content):
    for phone in phone_to:
        gsm_cmd = 'gsmsend -s emp01.app.com:15001 ' + phone + '@\"' + content + '\"'
        subprocess_pipe(gsm_cmd)

def sendmail_subject(subject, information):
    message = MIMEMultipart('alternative')
    message["Subject"] = subject
    message["From"] = mail_from
    message["To"] = ", ".join(mail_to)
    mail_server = smtplib.SMTP("hotswap-in.app.com")
    message.attach(MIMEText(information, 'html', _charset="utf-8"))
    mail_server.sendmail(mail_from, mail_to, message.as_string())
    mail_server.quit()

def print_table(errors):
    table_header = ['file', 'host', 'times']
    table_cont = errors

    html = ''
    
    html += '<html><head><style type="css">'
    html += 'table{border-collapse:collapse;border-spacing:0;border-left:1px solid #888;border-top:1px solid #888;background:#efefef;}'
    html += 'td{border-right:1px solid #888;border-bottom:1px solid #888;padding:5px 15px;}'
    html += 'th{white-space: nowrap;font-weight:bold;background:#ccc;}'
    html += '</style></head>'

    html += '<h2>alart video_shoubai [%s] dict not update warning</h2>' % server_name
    html += tabulate(table_cont, table_header, tablefmt="html", numalign="center", stralign="center")

    html += '<br />'
    html += '</html>'

    subject = 'alart [%s] dict not update warning [WARN]' % server_name
    sendmail_subject(subject, html)
    send_sms(subject)
    return html

def subprocess_pipe(cmd):
    cmd_arr = []
    cmd_str = ''

    if isinstance(cmd, str):
        cmd_str = cmd
    else:
        cmd_arr = cmd

    for cmd_item in cmd_arr:
        cmd_str += cmd_item + ' '

    logging.debug('cmd_str: %s' % cmd_str)

    pipe = subprocess.Popen(cmd_str, stdin = subprocess.PIPE,\
            stdout = subprocess.PIPE, stderr = subprocess.PIPE, \
            shell = True)

    stdout, stderr = pipe.communicate()
    return stdout, stderr

def get_file_stat(host, path, file):
    res = {
        'stat': UNKOWN,
        'last_time': 0,
    }
    try:
        file_dir = file[:file.rindex("/")]
        file_name = file[file.rindex("/")+1:]
    except ValueError:
        file_dir = './'
        file_name = file

    try:
        url = 'http://' + host + ':8980/?op=dir&path=' + path + '/' + file_dir
        logging.debug('file:%s url:%s' % (file, url))

        html = requests.get(url, timeout=0.1).text
        html = "".join(html.split())

        pattern = re.compile(r'>%s</a></td><td>.*?</td><td.*?>.*?</td><td>(?P<time>.*?)</td>.*?</tr>' % file_name)
        #logging.debug('pattern:%s' % pattern.pattern)
        match = pattern.search(html)
        if match:
            ts = match.group('time')
            t = time.mktime(time.strptime(ts, '%Y-%m-%d%H:%M:%S'))
            #logging.info('file_name:%s time:%s t:%d' % (file_name, ts, t))
            res['stat'] = OK
            res['last_time'] = t
            return res

    except Exception, e:
        logging.warning('error %s:%s', type(e), str(e))
        return res
    return res

def get_dns_info():
    get_instance_cmd = 'get_instance_by_service -Ds ' + dns_name

    dns_info, _ = subprocess_pipe(get_instance_cmd)
    
    infoes = dns_info.split('\n')
    
    res = []
    for info in infoes:
        if len(info) <= 0:
            continue
        host_path_arr = info.split(' ')
        host = host_path_arr[0]
        stat = int(host_path_arr[1])
        path = host_path_arr[2]
        logging.debug('host:%s stat:%d path:%s' % (host, stat, path))
        if stat == 0:
            res.append((host,path))
    return res
    
if __name__ == "__main__":

    #log.init_log('./monitor', level=logging.DEBUG)
    log.init_log('./monitor', level=logging.INFO)
    logging.info('start')

    infos = get_dns_info()

    count = 0
    all_error = []
    tmp_error = []
    for info in infos:
        #for test
        #if count >= 5:
        #    break
        #count += 1
        host = info[0]
        path = info[1]
        now = int(time.time())

        logging.info('now:%s host:%s path:%s' % (now, host, path))

        for file,timeout in monitor_files.iteritems():
            file_stat = get_file_stat(host, path, file)
            if file_stat['stat'] == NOT_EXIST:
                logging.warning('now:%s host:%s path:%s not_exist' % (now, host,path))
                tmp_error.append((file, host, 'remote file not exist'))
            elif file_stat['stat'] == UNKOWN:
                logging.warning('now:%s host:%s path:%s unkown' % (now, host,path))
            else:
                delta = now - file_stat['last_time']
                if delta > timeout:
                    logging.warning('now:%s host:%s path:%s timeout' % (now, host,path))
                    all_error.append((file, host, 'not update for:%d' % delta))
    for tup in tmp_error:
        all_error.append(tup)

    logging.info('all_error:%d total %d' % len(all_error), len(infos))
    if len(all_error) >= int(len(infos) * 0.1):
        logging.warning('all_error')
        print_table(all_error)
    logging.info('end')

