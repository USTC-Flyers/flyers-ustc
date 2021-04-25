import requests
import json.decoder
import time
import re

url = 'https://api.1point3acres.com/offer/colleges/typeahead'
url_program = 'https://api.1point3acres.com/offer/programs'
filename = 'world_universities_and_domains.json'
# filename = 'filtered_world_universities_and_domains.json'
with open('backend/data/' + filename) as f:
    data_raw = json.load(f)
    
def build_res(resp):
    unvi_1p3a = {}
    data = resp['data'][0]
    unvi_1p3a['area'] = data['area']
    unvi_1p3a['school_name'] = data['school_name']
    unvi_1p3a['school_name_cn'] = data['school_name_cn']
    unvi_1p3a['short_name'] = data['short_name']
    params_program = {'school': unvi_1p3a['short_name']}
    r = requests.get(url=url_program, params=params_program)
    resp = r.json()
    unvi_1p3a['programs'] = resp['programs']
    return unvi_1p3a

data_1p3a = []
search_more = []
search_null = []
i = 0
time_start = time.time()
for univ in data_raw:
    i += 1
    params = {'query': univ['name']}
    r = requests.get(url=url, params=params)
    resp = r.json()
    if len(resp['data']) != 1 or resp['errno'] != 0:
        m = '(.*)(\..*)'
        isSearch = False
        for domain in univ['domains']:
            s = re.search(m, domain)
            if s:
                params['query'] = s.groups()[0]
                r = requests.get(url=url, params=params)
                resp = r.json()
                if len(resp['data']) == 1 and resp['errno'] == 0:
                    data_1p3a.append(build_res(resp))
                    isSearch = True
                    break
        if not isSearch:
            search_null.append(univ['name'])
    else:
        data_1p3a.append(build_res(resp))
        
with open('backend/data/university_1p3a_v2.json', 'w') as outfile:
    json.dump(data_1p3a, outfile, ensure_ascii=False, indent=2)

print('-'*20)
print('Search more')
print(search_more)
print('-'*20)
print('Search null')
print(search_null)
        
        