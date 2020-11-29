#!/usr/bin/env bash
openssl genrsa -out ./tls/ca.key 2048
openssl req -x509 -new -nodes -key ./tls/ca.key -days 100000 -out ./tls/ca.crt -subj "/CN=admission_ca"
cat >./tls/server.conf <<EOF
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name
[req_distinguished_name]
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
extendedKeyUsage = clientAuth, serverAuth
EOF
openssl genrsa -out ./tls/server.key 2048
openssl req -new -key ./tls/server.key -out ./tls/server.csr -subj "/CN=opa.opa.svc" -config ./tls/server.conf
openssl x509 -req -in ./tls/server.csr -CA ./tls/ca.crt -CAkey ./tls/ca.key -CAcreateserial -out ./tls/server.crt -days 100000 -extensions v3_req -extfile ./tls/server.conf
