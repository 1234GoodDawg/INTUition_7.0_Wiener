import google_trans_new
from google_trans_new import google_translator
import tabula
import pandas as pd
import plotly.figure_factory as ff
import os


if file.endswith('.pdf'):

    tabula.convert_into(file,'data.csv', pages='all')
    df = pd.read_csv('data.csv') 

    translator = google_translator()
    
    def astype_per_column(df: pd.DataFrame, column: str, dtype):
        df[column] = df[column].astype(dtype)
  
    astype_per_column(df, df.columns[1], str)
  
    for i in range(len(df)):
        df.loc[i,'Name'] = translator.translate(df.iloc[i,1], lang_tgt = 'en')
  
    df.to_csv('translated_data.csv',sep=',')
    
else if file.endswith('.xlsx'):
    
    df2 = pd.read_excel('japanese_chemicals.xlsx')
    df2 = df2.take([3,25],axis=1)
  
    indexes_to_drop = list(range(0,25)) + list(range(38,50))
    indexes_to_keep = set(range(df2.shape[0])) - set(indexes_to_drop)
    df_sliced = df2.take(list(indexes_to_keep))

    astype_per_column(df_sliced, df_sliced.columns, str)
    df_sliced.reset_index(inplace=True)

    for i in range(len(df_sliced)):
        df_sliced.loc[i,'Name'] = translator.translate(df_sliced.iloc[i,1], lang_tgt = 'en')
    
    df_sliced.to_csv('translated_data_jap.csv',sep=',')
