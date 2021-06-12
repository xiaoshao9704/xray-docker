# xray-docker
xray-server dockerfile

# Supported env
1. UUID : xray uuid (default random create)
2. PASSWORD : trojan password (default is UUID)
3. HOST : if HOST not empty, will create cert by certbot else will self signature
4. WEBSOCKET : ws uri
5. VMESSTCP : vmess tcp uri
6. VMESSWS : vmess ws url

# More

you can cat /xray/info.txt
