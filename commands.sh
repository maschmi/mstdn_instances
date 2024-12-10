curl 'https://api.joinmastodon.org/servers?language=&category=&region=&ownership=&registrations=' | jq > servers.json
jq '.[] | select(.domain)' servers.json > domain.txt
sed 's/"//g' domains.txt | while read line; do curl "https://$line/api/v1/instance" | jq >> instances.json; done
jq '. | {uri, title, configuration}' instances.json > configurations.json

