# root user
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

uuid=$(cat /proc/sys/kernel/random/uuid)

# prompt email
echo "Please enter your email address:"
read email

# prompt address
echo "Please enter your address name:"
read address

curl https://get.acme.sh | sh -s email=$email

# /etc/v2fly/config.json
bash <(curl -L https://raw.githubusercontent.com/v2fly/fhs-install-v2ray/master/install-release.sh)
systemctl enable v2fly

# /etc/tls-shunt-proxy/config.yaml
bash <(curl -L -s https://raw.githubusercontent.com/liberal-boy/tls-shunt-proxy/master/dist/install.sh)
systemctl enable tls-shunt-proxy

# ensure /var/www/html
mkdir -p /var/www/html

# generate config.json
cat ./server/config.json | sed "s/%UUID%/$uuid/g" > /etc/v2ray/config.json
cat ./server/tls-shunt-proxy.yaml | sed "s/%ADDRESS%/$address/g" > /etc/tls-shunt-proxy/config.yaml

systemctl daemon-reload
systemctl restart v2ray
systemctl restart tls-shunt-proxy

echo "Server setup complete"
echo "UUID: $uuid"