sudo -v
cd /etc/httpd/conf || exit
sudo openssl genpkey -algorithm RSA -pkeyopt rsa_keygen_bits:4096 -out "$1".key
sudo chmod 400 "$1".key
sudo openssl req -new -sha256 -key "$1".key -out "$1".csr
sudo openssl x509 -req -days 1095 -in "$1".csr -signkey "$1".key -out "$1".crt
