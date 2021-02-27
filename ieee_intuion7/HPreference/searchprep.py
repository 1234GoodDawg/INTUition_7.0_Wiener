import pandas as pd
from search_pdf import find

def prep(filename):
    temp = pd.read_csv(filename)
    chemical_names = set(temp['Name'].to_list())
    print(chemical_names)

    chemical_names = ['Mercury','and']
    for item in chemical_names:
        if(find(item)):
            continue
        else:
            wordlist = item.split(' ')
            new = [x for x in wordlist if x not in ['and','other','or','the','in']]
            for elem in new:
                if(find(elem)):
                    break