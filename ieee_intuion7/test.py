import pdfplumber
import numpy as np
import pandas as pd
from pandas.plotting import table 
import matplotlib.pyplot as plt

query = 'Mercury'
mylist = []

pdf = pdfplumber.open('HP.pdf')

for i in range(len(pdf.pages)):
    if(query in pdf.pages[i].extract_text()):
        try:
            cur = np.array(pdf.pages[i].extract_table())
            for j in range(cur.shape[0]):
                if(query in cur[j][0]):
                    mylist.append(cur[j])

        except:
            pass

for i in range(len(mylist)):
    for j in range(len(mylist[i])):
        mylist[i][j] = mylist[i][j].replace('\n','')

mypanda = pd.DataFrame(mylist)
ax = plt.subplot(111, frame_on=False)
ax.xaxis.set_visible(False)
ax.yaxis.set_visible(False)
table(ax, mypanda)

plt.savefig('Requirements.png')