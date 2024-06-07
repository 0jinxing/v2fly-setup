curl -LO https://github.com/klzgrad/forwardproxy/releases/download/v2.7.6-naive2/caddy-forwardproxy-naive.tar.xz
mkdir -p /usr/local/etc/caddy
mkdir -p /var/www/html
tar -xvf caddy-forwardproxy-naive.tar.xz -C /usr/local/etc/caddy

# prompt for email and password
echo "Please enter your email and password for the proxy"

read -p "Email: " email
read -sp "Password: " password

echo "Please enter your address name:"
read address

cat ./Caddyfile | sed "s/%ADDRESS%/$address/g" | sed "s/%EMAIL%/$email/g"  | sed "s/%PASSWORD%/$password/g"  > /usr/local/etc/caddy/Caddyfile


