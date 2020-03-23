from kubernetes import client, config, watch
import subprocess

def main():
    config.load_kube_config()
    api = client.CoreV1Api()
    ns = api.list_namespace()
    print(ns)
main()
