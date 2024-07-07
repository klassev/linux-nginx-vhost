### Code to ~/.zshrc
### code ~/.zshrc


alias nginxreload="sudo nginx -s reload"
alias nginxrestart="sudo nginx -s stop && sudo nginx"
alias nginxa ="ls -la /etc/nginx/sites-available/"
alias nginxe ="ls -la /etc/nginx/sites-enabled/"

### create site folder
### nginxcreate test.test  (if site in ~/www/test.test)
### nginxcreate laravel.test /... full path to .../laravel.test/public
function nginxcreate() {
    sudo wget https://raw.githubusercontent.com/klassev/linux-nginx-vhost/main/nginx-vserver-linux.conf -O /etc/nginx/sites-available/$1
    
    sudo sed -i '' "s:{{host}}:$1:" /etc/nginx/sites-available/$1

    if [ "$2" ]; then
        sudo sed  -i '' "s:{{root}}:$2:" /etc/nginx/sites-available/$1
    else
        sudo sed  -i '' "s:{{root}}:$HOME/www/$1:" /etc/nginx/sites-available/$1
    fi


    nginxmkcert $1

    nginxrestart

    sudo ln -s /etc/nginx/sites-available/$1 /etc/nginx/sites-enabled/$1

    nginxedit $1
 }

 function nginxmkcert() {
    mkcert -key-file $1.key -cert-file $1.crt $1 "*.$1" localhost 127.0.0.1 ::1
    sudo chmod 644 $1.key && sudo chmod 644 $1.crt
    mv $1.key /etc/ssl/certs && mv $1.crt /etc/ssl/certs
 }

 function nginxedit() {
     sudo nano /etc/nginx/sites-available/$1.conf
 }