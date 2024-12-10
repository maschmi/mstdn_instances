# A list of configurations for Mastodon Instances

(10.12.2024)

You can find multiple files here:

* servers.json: all the servers listed on joinmastodon.org
* domains.txt: the domains of the servers
* instances.json: the output of calling https://$domain//api/v1/instance for each server
* configurations.json: the configurations for each instance
* command.sh: the commands used to create the files

This was triggerd by https://caneandable.social/@WeirdWriter/113618893222970442
about the need to see how mastodon instances are configured. 

Please be aware, this was only a quick 'hack' to see how this data can be obtained and
parsed. If somone finds this useful or I find time, I may turn this in to a small
website or a csv to be human readable. For now I hope the 'configurations.json' helps.

## Commands used

```
curl 'https://api.joinmastodon.org/servers?language=&category=&region=&ownership=&registrations=' \\n  -H 'sec-ch-ua-platform: "Linux"' \\n  -H 'Referer: https://joinmastodon.org/' \\n  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36' \\n  -H 'sec-ch-ua: "Chromium";v="130", "Google Chrome";v="130", "Not?A_Brand";v="99"' \\n  -H 'sec-ch-ua-mobile: ?0'https://mastodon.social/api/v1/instance | jq > servers.json
jq '.[] | select(.domain)' servers.json
sed 's/"//g' domains.txt | while read line; do curl "https://$line/api/v1/instance" | jq >> instances.json; done
jq '. | {uri, title, configuration}' instances.json > configurations.json
```