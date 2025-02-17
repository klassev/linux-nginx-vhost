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

### Edit .zshrc

```bash
code ~/.zshrc
```


