#!/usr/bin/env bash
 sudo docker login -u abamboi -p 'xxxx' mtr.external.otc.telekomcloud.com
 export DOCKER_CONTENT_TRUST_SERVER=https://notary.external.otc.telekomcloud.com
 sudo notary init abamboi/myfirstrepo -s https://notary.external.otc.telekomcloud.com
 ---
 https://docs.docker.com/engine/security/trust/trust_sandbox/
 https://docs.docker.com/engine/security/trust/trust_automation/
 https://docs.docker.com/engine/security/trust/content_trust/
 https://docs.docker.com/notary/advanced_usage/
 https://docs.docker.com/get-started/part2/
 https://docs.docker.com/notary/getting_started/
 https://werner-dijkerman.nl/2019/02/24/signing-docker-images-with-notary-server/
 https://github.com/theupdateframework/notary
 https://help.sonatype.com/repomanager3/formats/docker-registry/docker-content-trust

1. Docker login
 docker login -u $USERNAME -p $PASSWORD mtr.external.otc.telekomcloud.com

 2. Enable DCT
export DOCKER_CONTENT_TRUST=1
export DOCKER_CONTENT_TRUST_SERVER=https://notary.external.otc.telekomcloud.com

declare -x DOCKER_CONTENT_TRUST_SERVER="https://notary.external.otc.telekomcloud.com"
declare -x DOCKER_CONTENT_TRUST="1"
