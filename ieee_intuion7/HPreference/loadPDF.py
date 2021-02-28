from bs4 import BeautifulSoup
from googlesearch import search 
import urllib as ul
import pdfplumber
import numpy as np

mypath = '/tmp/'
if not os.path.isdir(mypath):
    os.makedirs(mypath)
        
gen = search('HP Standard 011 General Specification for the Environment', tld='com', lang='en', num=10, start=0, stop=None, pause=2.0)
url = next(gen)

response = ul.request.urlopen(url)    
file = open("/tmp/HP.pdf", 'wb')
file.write(response.read())
file.close()
