# Creating a Virtual Host in NGINX with SSL


### Install mkcert  

```bash
sudo apt install libnss3-tools -y
wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64
mv mkcert-v1.4.4-linux-amd64 mkcert
chmod +x mkcert
sudo cp mkcert /usr/local/bin/
mkcert -install
```

```bash
mkcert mydomen.test '*.mydomen.test' localhost 127.0.0.1 ::1
sudo cp mydomen.test+4.pem /etc/ssl/certs/mydomen.crt && sudo cp mydomen.test+4-key.pem /etc/ssl/private/mydomen-key.key
sudo chmod 644 /etc/ssl/certs/mydomen.crt && sudo chmod 644 /etc/ssl/private/mydomen-key.key
```

### Edit .zshrc

```bash
code ~/.zshrc
```


