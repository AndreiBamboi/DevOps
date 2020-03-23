from kubernetes import client, config, watch
import subprocess

def main():
    # config.load_incluster_config()
    # config.load_kube_config()
    # api = client.CoreV1Api()
    # ns = api.list_namespace(pretty=True)
    # print(ns)
    res = subprocess.check_output(["kubectl", "get", "ns"])
    for line in res.splitlines():
        print(line)

# process the output line by line

main()
