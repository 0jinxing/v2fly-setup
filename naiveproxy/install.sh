mkdir -p /etc/caddy
mkdir -p /var/www/html

apt install -y curl xz-utils

curl -LO https://github.com/klzgrad/forwardproxy/releases/download/v2.7.6-naive2/caddy-forwardproxy-naive.tar.xz
tar -xf caddy-forwardproxy-naive.tar.xz

mv ./caddy-forwardproxy-naive/caddy /usr/bin/caddy
rm -rf caddy-forwardproxy-naive caddy-forwardproxy-naive.tar.xz

chmod +x /usr/bin/caddy

groupadd --system caddy
useradd --system \
    --gid caddy \
    --create-home \
    --home-dir /var/lib/caddy \
    --shell /usr/sbin/nologin \
    --comment "Caddy web server" \
    caddy

mv ./caddy.service /etc/systemd/system/caddy.service

# prompt email
echo "Please enter your email address:"
read email

# prompt address
echo "Please enter your address name:"
read address

# prompt password
echo "Please enter your password:"
read password

cat ./Caddyfile | sed "s/%ADDRESS%/$address/g" | sed "s/%EMAIL%/$email/g"  | sed "s/%PASSWORD%/$password/g"  > /etc/caddy/Caddyfile

systemctl daemon-reload
systemctl enable caddy
systemctl start caddy


