import pdfplumber
import numpy as np
import pandas as pd
from pandas.plotting import table 
import matplotlib.pyplot as plt
import plotly.graph_objects as go
import plotly.io
import os

def find(query, num):

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

    if(len(mylist) != 0):
        for i in range(len(mylist)):
            for j in range(len(mylist[i])):
                try:
                    mylist[i][j] = mylist[i][j].replace('\n','')
                except:
                    pass
    
        mypanda = pd.DataFrame(mylist)
        fig = go.Figure(data=[go.Table(header=dict(values=list(mypanda.columns),
                        fill_color='paleturquoise',
                        align='left'),
                        cells=dict(values=[mypanda[item] for item in mypanda.columns],
                        fill_color='lavender',
                        align='left'))])

        plotly.io.write_image(fig,'/tmp/requirements/requirements_'+f'{query}'+'.png',format='png',width=1500,height=1500)
        return True 
        
    else:
        return False
