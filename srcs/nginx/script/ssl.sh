#! /bin/bash

cd /etc/ssl

if [ "$#" -ne 1 ]
then
  echo "Error: No domain name argument provided"
  echo "Usage: Provide a domain name as an argument"
  exit 1
fi

DOMAIN=$1

# Generate Private key 
openssl genrsa -out ${DOMAIN}.key 2048

# Create csf conf
cat > csr.conf <<EOF
[req]
default_bits = 2048
prompt = no
default_md = sha256
req_extensions = req_ext
distinguished_name = dn

[dn]
C = KO
ST = Seoul
L = Seoul
O = mypark
OU = mypark Dev
CN = ${DOMAIN}

[req_ext]
subjectAltName = @alt_names

[alt_names]
DNS.1 = ${DOMAIN}
IP.1 = ${DOMAIN}

EOF

# create CSR request using private key
openssl req -new -key ${DOMAIN}.key -out ${DOMAIN}.csr -config csr.conf

# Create root CA & Private key
openssl req -x509 \
            -sha256 -days 356 \
            -nodes \
            -newkey rsa:2048 \
            -subj "/CN=${DOMAIN}/C=KO/L=Seoul" \
            -keyout rootCA.key -out rootCA.crt 

# Create a external config file for the certificate
cat > cert.conf <<EOF

authorityKeyIdentifier = keyid,issuer
basicConstraints = CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names
 
[alt_names]
DNS.1 = ${DOMAIN}
IP.1 = ${DOMAIN}

EOF

# Create SSl with self signed CA
openssl x509 -req \
    -in ${DOMAIN}.csr \
    -CA rootCA.crt -CAkey rootCA.key \
    -CAcreateserial -out ${DOMAIN}.crt \
    -days 365 \
    -sha256 -extfile cert.conf