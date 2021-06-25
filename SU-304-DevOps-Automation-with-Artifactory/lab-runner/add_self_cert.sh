apk add openssl
cd /usr/local/share/ca-certificates/
openssl s_client -showcerts -connect "${ARTIFACTORY_HOSTNAME}":443 </dev/null 2>/dev/null|openssl x509 -outform PEM >artifactory_cert.pem
openssl x509 -outform der -in artifactory_cert.pem -out art_cert.crt
cp art_cert.crt /usr/local/share/ca-certificates/.
update-ca-certificates
curl -k https://gkn-nginx.c.soleng-dev.internal
cd -
