# https://randomuser.me/documentation#nationalities
nationalities=("au" "br" "ca" "ch" "de" "dk" "es" "fi" "fr" "gb" "ie" "ir" "no" "nl" "nz" "tr" "us")

for nat in "${nationalities[@]}"
do
  curl -s "https://randomuser.me/api/?nat=$nat&results=1000&format=json" | jq -c '.results[]' > "users.$nat.json"
done
