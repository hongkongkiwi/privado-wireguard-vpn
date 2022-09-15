Privado Wireguard VPN
=======================

Privado offers Wireguard support, but only using their client, I wanted to use wireguard in a docker container for my own purposes.

I've written some scripts to pull down the credentials so that you can get the wireguard configs for your own client.

## Quickstart

Get the code

```
git clone https://github.com/hongkongkiwi/privado-wireguard-vpn.git
cd privado-wireguard-vpn
```

Create a credentials file with your VPN creds (premium account required)

```
cat >creds.env <<EOF
PRIVADO_USERNAME=<your_username>
PRIVADO_PASSWORD=<your_password>
EOF
```

Login to get server list

```
./login
```

Get server list json

```
./get_servers
```

Show a human readable list of all servers

```
./list_servers
```

Request a wireguard ip from the server

```
./login_wireguard_server "<server_url>"
```

```
./gen_wireguard_conf "<server_url>" "<wg_interface_ip>" "wg0.conf"
```

When your finished with the ip, release it

```
./logout_wireguard_server "<server_url>" "<wg_interface_ip>"
```

OR if you prefer, release all ips for a server

```
./logout_wireguard_server "<server_url>"
```

Not very useful ... but if you want to get your account data

```
./get_account_details
```
