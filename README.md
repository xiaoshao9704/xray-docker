# xray-docker
xray-server dockerfile

# Supported env
UUID : xray uuid (default random create)
PASSWORD : trojan password (default is UUID)
HOST : if HOST not empty, will create cert by certbot else will self self_signature
WEBSOCKET : ws uri
VMESSTCP : vmess tcp uri
VMESSWS : vmess ws url

# More

you can cat /xray/info.txt