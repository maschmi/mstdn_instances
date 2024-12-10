curl curl 'https://api.joinmastodon.org/servers?language=&category=&region=&ownership=&registrations=' \\n  -H 'sec-ch-ua-platform: "Linux"' \\n  -H 'Referer: https://joinmastodon.org/' \\n  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/130.0.0.0 Safari/537.36' \\n  -H 'sec-ch-ua: "Chromium";v="130", "Google Chrome";v="130", "Not?A_Brand";v="99"' \\n  -H 'sec-ch-ua-mobile: ?0'https://mastodon.social/api/v1/instance | jq > servers.json
jq '.[] | select(.domain)' servers.json
sed 's/"//g' domains.txt | while read line; do curl "https://$line/api/v1/instance" | jq >> instances.json; done
jq '. | {uri, title, configuration}' instances.json > configurations.json

