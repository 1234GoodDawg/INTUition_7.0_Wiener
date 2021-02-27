import matplotlib.pyplot as plt
import seaborn as sns
from wordcloud import WordCloud
import pandas as pd
import numpy as np

def visualise(filename):
    searched = pd.read_csv(filename)
    sns_plot = sns.catplot(y='Name', data = searched, kind='count',aspect=2)
    sns_plot.savefig("searchhistory.png")

    f = plt.figure(figsize=(24,12))
    var, count = np.unique(searched['Name'].values, return_counts=True)
    freq = dict(zip(var,count))
    wordcloud = WordCloud(width=800,height=400,background_color='white').generate_from_frequencies(freq)
    plt.imshow(wordcloud,interpolation="bilinear")
    plt.axis('off')
    plt.savefig('Wordcloud.png')

    f = plt.figure()
    patches, texts = plt.pie(freq.values())
    plt.legend(patches, freq.keys(), loc="best", fontsize=5)
    plt.axis('equal')
    plt.tight_layout()
    plt.savefig('Piechart.png')

visualise('mock.csv')