import requests

file = open('/var/lib/prometheus-dropzone/metrics.prom', 'w') 

try:
    r = requests.head("https://httpstat.us/503")
    print(r.status_code)
    file.write('sample_external_url_response_ms{url="https://httpstat.us/503"} = '+ str(r.status_code) +'\n' )
    # prints the int of the status code.)
except requests.ConnectionError:
    file.write('sample_external_url_up{url="https://httpstat.us/503"} = 0\n' )
    print("failed to connect")
else:
    file.write('sample_external_url_up{url="https://httpstat.us/503"} = 1\n' )
    print("Connected")


try:
    r = requests.head("https://httpstat.us/200")
    print(r.status_code)
    file.write('sample_external_url_response_ms{url="https://httpstat.us/200"} = '+ str(r.status_code) +'\n' )
    # prints the int of the status code.)
except requests.ConnectionError:
    file.write('sample_external_url_up{url="https://httpstat.us/200"} = 0\n' )
    print("failed to connect")
else:
    file.write('sample_external_url_up{url="https://httpstat.us/200"} = 1\n' )
    print("Connected")
