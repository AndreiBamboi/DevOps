from kubernetes import client, config, watch
def main():
    config.load_kube_config()