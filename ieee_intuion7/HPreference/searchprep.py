import pandas as pd
from search_pdf import find

def prep(filename):
    temp = pd.read_csv(filename)
    chemical_names = set(temp['Name'].to_list())
    i = 0
    
    for item in chemical_names:
        if(find(item)):
            i +=1
            print(f"Found {i}/{len(chemical_names)} requirements"}
            continue
        else:
            wordlist = item.split(' ')
            new = [x for x in wordlist if x not in ['and','other','or','the','in']]
            for elem in new:
                if(find(elem)):
                    i +=1
                    print(f"Found {i}/{len(chemical_names)} requirements"}
                    break
