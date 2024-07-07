### code ~/.zshrc


alias nginxreload="sudo nginx -s reload"
alias nginxrestart="sudo nginx -s stop && sudo nginx"
alias nginxa ="ls -la /etc/nginx/sites-available/"
alias nginxe ="ls -la /etc/nginx/sites-enabled/"

function nginxcreate() {
    wget https://raw.githubusercontent.com/klassev/macos-brew-vhosts/master/nginx-vserver-m1.conf -O /opt/homebrew/etc/nginx/servers/$1.conf
    
    sed -i '' "s:{{host}}:$1:" /opt/homebrew/etc/nginx/servers/$1.conf

    if [ "$2" ]; then
        sed  -i '' "s:{{root}}:$2:" /opt/homebrew/etc/nginx/servers/$1.conf
    else
        sed  -i '' "s:{{root}}:$HOME/Sites/$1:" /opt/homebrew/etc/nginx/servers/$1.conf
    fi

    #nginxaddssl $1

    nginxmkcert $1

    nginxrestart

    code /opt/homebrew/etc/nginx/servers/$1.conf
 }

 function nginxaddssl() {
     openssl req \
        -x509 -sha256 -nodes -newkey rsa:2048 -days 3650 \
        -subj "/CN=$1" \
        -reqexts SAN \
        -extensions SAN \
        -config <(cat /System/Library/OpenSSL/openssl.cnf; printf "[SAN]\nsubjectAltName=DNS:$1") \
        -keyout /opt/homebrew/etc/nginx/ssl/$1.key \
        -out /opt/homebrew/etc/nginx/ssl/$1.crt

    sudo security add-trusted-cert -d -r trustRoot -k /Library/Keychains/System.keychain /opt/homebrew/etc/nginx/ssl/$1.crt
 }

 function nginxmkcert() {
    mkcert -key-file $1.key -cert-file $1.crt $1 "*.$1" localhost 127.0.0.1 ::1
    sudo chmod 644 $1.key && sudo chmod 644 $1.crt
    mv $1.key /opt/homebrew/etc/nginx/ssl && mv $1.crt /opt/homebrew/etc/nginx/ssl
 }

 function nginxedit() {
     code /opt/homebrew/etc/nginx/servers/$1
 }

 function nginxlist() {
     ll /opt/homebrew/etc/nginx/servers/
 }