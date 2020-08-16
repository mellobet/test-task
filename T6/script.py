#!/usr/bin/env python
# coding: utf-8

from bs4 import BeautifulSoup
import urllib3
import time
import gzip
import re

# Configs
BASE_URL = 'https://dumps.wikimedia.org/other/pagecounts-raw/2016/2016-01/'
FILENAME_HEAD = 'pagecounts-'
READ_INDEX_TIMEOUT = 5
READ_TIMEOUT = 120
CONNECT_TIMEOUT = 10

http = urllib3.PoolManager()

status = None
while status != 200:
    r = http.request('GET', BASE_URL,
                     timeout=urllib3.Timeout(connect=CONNECT_TIMEOUT, read=READ_INDEX_TIMEOUT))
    status = r.status
    time.sleep(2)

# Init Soup
soup = BeautifulSoup(r.data, features='html.parser')

# Get all filenames starting with "pagecounts-"
pg_files = [f['href'] for f in soup.find_all ('a', href=True) if f['href'].startswith(FILENAME_HEAD)]
print(f'{len(pg_files)} files were found in: {BASE_URL}')

regex = re.compile(r'en\ Bitcoin [0-9]+')
regex_hits = []

for pg_file in pg_files:

    # Compose File URL
    FILE_URL = BASE_URL + pg_file
    # Get remote file data
    file_data = http.request('GET', FILE_URL, preload_content=False,
                             timeout=urllib3.Timeout(connect=CONNECT_TIMEOUT, read=READ_TIMEOUT))

    with gzip.open(file_data, 'rb') as f:
        file_content = f.read().decode("utf-8")

    try:
        find = re.findall(regex, file_content)[0]
        hits = int(find.split(' ')[2])
        # append the finding to a list as int.
        regex_hits.append(hits)
        print(f'Match: {find}')
        print(f'{pg_file} has {hits} hits...')
        print(f'Accumulated hits: {sum(regex_hits)}')

    except IndexError:
        print(f'No findings for file {pg_file}...')
        print(f'Accumulated hits: {sum(regex_hits)}')
