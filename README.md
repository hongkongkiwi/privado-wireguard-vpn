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

Generate a wireguard compatible conf file to wg0.conf

```
./gen_wireguard_conf "<server_url>" "<wg_interface_ip>" "wg0.conf"
```

When your finished with the ip, release it (be nice), although it seems that this is not necessary as IPs will time out if not used

```
./logout_wireguard_server "<server_url>" "<wg_interface_ip>"
```

OR if you prefer, release all ips for a server

```
./logout_wireguard_server "<server_url>"
```

When your finished and want to clear all session data (I could not find a logout endpoint)

```
./clear_session_data
```

Not very useful ... but if you want to get your account data

```
./get_account_details
```

If you want a simple script to pull a config and do all the steps you can run this

```
./wireguard_conf_start_to_finish "ams-101.vpn.privado.io" "wg0.conf"
```
