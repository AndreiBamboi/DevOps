from kubernetes import client, config, watch

# Configs can be set in Configuration class directly or using helper utility
config.load_kube_config()

v1 = client.CoreV1Api()
w = watch.Watch()
for event in w.stream(v1.list_namespace, _request_timeout=600):
    print("Event: %s %s " % (event['type'], event['object'].metadata.name))
    # print(event)

print("Ended.")