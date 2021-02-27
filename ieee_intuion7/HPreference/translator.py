import google_trans_new
from google_trans_new import google_translator
import tabula
import pandas as pd
import plotly.figure_factory as ff


file = 'chemicals_chinese.pdf'
tabula.convert_into(file,'data.csv', pages='all')
df = pd.read_csv('data.csv') 
translator = google_translator()

def astype_per_column(df: pd.DataFrame, column: str, dtype):
    df[column] = df[column].astype(dtype)

astype_per_column(df, df.columns[1], str)

for i in range(len(df)):
  df.loc[i,'Name'] = translator.translate(df.iloc[i,1], lang_tgt = 'en')

df.to_csv('translated_data.csv',sep=',')



fig =  ff.create_table(df)
fig.update_layout(
    autosize=False,
    width=1700,
    height=1000,
)
fig.write_image("table_plotly.png", scale=2)
fig.show()
