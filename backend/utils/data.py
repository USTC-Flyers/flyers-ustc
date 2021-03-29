import requests
import json.decoder
import time
url = 'https://api.1point3acres.com/offer/colleges/typeahead'
url_program = 'https://api.1point3acres.com/offer/programs'
filename = 'world_universities_and_domains.json'
# filename = 'filtered_world_universities_and_domains.json'
with open('backend/data/' + filename) as f:
    data_raw = json.load(f)

data_1p3a = []
search_more = []
search_null = []
i = 0
time_start = time.time()
for univ in data_raw:
    i += 1
    if i % 100 == 0:
        print('100 in {:.4f}s'.format(time.time() - time_start))
        time_start = time.time()
    params = {'query': univ['name']}
    r = requests.get(url=url, params=params)
    resp = r.json()
    if len(resp['data']) < 1 or resp['errno'] != 0:
        search_null.append(univ['name'])
    elif len(resp['data']) > 1:
        search_more.append(univ['name'])
    else:
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
        data_1p3a.append(unvi_1p3a)
        
with open('backend/data/university_1p3a.json', 'w') as outfile:
    json.dump(data_1p3a, outfile, ensure_ascii=False, indent=2)

print('-'*20)
print('Search more')
print(search_more)
print('-'*20)
print('Search null')
print(search_null)
        
        