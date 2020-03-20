import requests
import os
import json
import logging
import sys
import kubernetes

log = logging.getLogger(__name__)
out_hdlr = logging.StreamHandler(sys.stdout)
out_hdlr.setFormatter(logging.Formatter('%(asctime)s %(message)s'))
out_hdlr.setLevel(logging.INFO)
log.addHandler(out_hdlr)
log.setLevel(logging.INFO)
v1 = kubernetes.client.CoreV1Api()
print(v1)
# base_url = "https://k8s-elb-a920f3773b7624fa.elb.eu-north-1.amazonaws.com:6443"
base_url = "http://127.0.0.1:8001"

def event_loop():
    log.info("Starting the service")
    # url = '{}/api/v1/namespaces/{}/configmaps?watch=true"'.format(
    #     base_url, namespace)
    url = '{}/api/v1/namespaces/?watch=true"'.format(base_url)
    r = requests.get(url, stream=True)
    # We issue the request to the API endpoint and keep the conenction open
    for line in r.iter_lines():
        obj = json.loads(line)
        # We examine the type part of the object to see if it is MODIFIED
        event_type = obj['type']
        # and we extract the configmap name because we'll need it later
        print(obj)
        if event_type == "ADDED":
            log.info("Modification detected")
            print(obj)


event_loop()

