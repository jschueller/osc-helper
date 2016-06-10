#!/usr/bin/env python


import argparse
from robobrowser import RoboBrowser
import re
import urllib
import urllib.request
import os
import subprocess

parser = argparse.ArgumentParser(description='Process some integers.')
parser.add_argument('project', metavar='project', type=str,
                    help='name of the project')
parser.add_argument('codename', metavar='codename', type=str,
                    help='distribution codename')
parser.add_argument('pkgname', metavar='pkgname', type=str,
                    help='package name')

args = parser.parse_args()
opts = vars(parser.parse_args())


debian_tags = {'squeeze': 'Debian_6.0', 'wheezy': 'Debian_7.0', 'jessie': 'Debian_8.0'}
ubuntu_tags = {'precise': 'xUbuntu_12.04', 'trusty': 'xUbuntu_14.04', 'xenial': 'xUbuntu_16.04'}

all_tags= dict()
all_tags.update(debian_tags)
all_tags.update(ubuntu_tags)

if opts['codename'] in debian_tags.keys():
    dist = 'debian'
elif opts['codename'] in ubuntu_tags.keys():
    dist = 'ubuntu'
else:
    raise TypeError('invalid codename')

def match_source(tag):
    return tag.name=='a' and tag.has_attr('href') and tag.has_attr('title') and tag['title']=='Source package building this package'

for pkgname in opts['pkgname'].split(','):



    browser = RoboBrowser()
    if dist == 'ubuntu':
        url = 'http://packages.ubuntu.com/source/'+opts['codename']+'/'+pkgname
        browser.open(url)
        if b'No such package' in browser.response.content:
            url = 'http://packages.ubuntu.com/'+opts['codename']+'/'+pkgname
            print(url)
            browser.open(url)
            if b'No such package' in browser.response.content:
                raise TypeError('no package found')
            source_links = browser.find_all(match_source)
            pkgname = source_links[0].contents[0]

    else:
        raise TypeError('invalid dist')

    if os.path.exists(pkgname):
        continue

    def match_logout(tag):
        return tag.name=='a' and tag.has_attr('href') and 'http://archive.ubuntu.com' in tag['href']
    archive_links = browser.find_all(match_logout)

    cmd = 'osc mkpac '+pkgname
    #stdout=subprocess.PIPE, stderr=subprocess.PIPE
    if subprocess.call(cmd, shell=True) != 0:
        raise TypeError('cmd failed:' + cmd)

    for archive_link in archive_links:
        url = archive_link['href']
        fname = pkgname+'/'+os.path.basename(url)
        if fname[-3:] == 'dsc':
            fname = fname.split('_')[0] +'-'+ all_tags[opts['codename']]+'.dsc'
        local_filename, headers = urllib.request.urlretrieve(url, fname)

    cmd = 'osc add '+pkgname + '/*'
    if subprocess.call(cmd, shell=True) != 0:
        raise TypeError('cmd failed:' + cmd)
    cmd = 'osc ci '+pkgname + ' -m "Import '+pkgname+'"'
    if subprocess.call(cmd, shell=True) != 0:
        raise TypeError('cmd failed:' + cmd)
