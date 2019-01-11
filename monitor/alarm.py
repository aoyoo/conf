#!/usr/bin/python
# -*- coding: utf-8 -*-

import smtplib
import os, sys
import datetime
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText

last_date = datetime.date.today() - datetime.timedelta(days=1)
mail_from = 'app@app.com'
mail_to = ['app@app.com']

def sendmail_subject(subject, information):
    message = MIMEMultipart('alternative')
    message["Subject"] = subject
    message["From"] = mail_from
    message["To"] = ", ".join(mail_to)
    mail_server = smtplib.SMTP("hotswap-in.app.com")
    message.attach(MIMEText(information, 'html', _charset="utf-8"))
    mail_server.sendmail(mail_from, mail_to, message.as_string())
    mail_server.quit()

if __name__ == '__main__':
    sendmail("111")
