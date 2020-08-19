#!/usr/bin/env python
# coding: utf-8

from bs4 import BeautifulSoup
import urllib3
import time
import gzip
import re
from urllib3.exceptions import ReadTimeoutError
import tempfile

# ToDo: More Exception catching. Functions. retry management.

# Configs
BASE_URL = 'https://dumps.wikimedia.org/other/pagecounts-raw/2016/2016-01/'
FILENAME_HEAD = 'pagecounts-'
READ_TIMEOUT = 30
CONNECT_TIMEOUT = 10

ONE_MEG = 2**20
CHUNK_SIZE = ONE_MEG//2

http = urllib3.PoolManager(timeout=urllib3.Timeout(connect=CONNECT_TIMEOUT, read=READ_TIMEOUT))

status = None
while status != 200:
    r = http.request('GET', BASE_URL)
    status = r.status
    time.sleep(2)

# Init Soup
soup = BeautifulSoup(r.data, features='html.parser')

# Get all filenames starting with "pagecounts-"
pg_files = [f['href'] for f in soup.find_all ('a', href=True) if f['href'].startswith(FILENAME_HEAD)]
print(f'{len(pg_files)} files were found in: {BASE_URL}')

# Regex named groups
regex = re.compile(r'(?P<domain>en) (?P<term>[Bb]itcoin) (?P<hits_number>\d+)')
acc_hits = 0

for pg_file in pg_files:

    # Compose File URL
    FILE_URL = BASE_URL + pg_file
    # Get remote file data
    r = http.request('GET', FILE_URL, preload_content=False)
    # Get file size.
    content_bytes = int(r.headers.get("Content-Length"))

    print(f'Downloading and Unzipping: {FILE_URL}')

    chunks = 0
    with tempfile.TemporaryFile(mode='w+b') as fp:
        for chunk in r.stream(CHUNK_SIZE):
            print(f'Downloaded: {((CHUNK_SIZE * chunks) / content_bytes) * 100:.1f}%')
            fp.write(chunk)
            chunks += 1
            
        r.release_conn()

        # Reset fp pointer
        fp.seek(0)

        # Opened as text (rt) no decoding needed.
        with gzip.open(fp, 'rt') as f:
            file_content = f.read()
        
        print(f'Gzip file opened - searching a regex match')

        try:
            find = regex.search(file_content)
            hits = int(find.group('hits_number'))

            acc_hits += hits
            print(f'Match: {find.group(0)}')
            print(f'{pg_file} has {hits} hits.')
            print(f'Accumulated hits: {acc_hits}')

        except AttributeError:
            print(f'No findings for file {pg_file}.')
            print(f'Accumulated hits: {acc_hits}')
