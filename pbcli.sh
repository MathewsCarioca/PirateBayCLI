#!/bin/bash

OPCOES=(
"Search Game"
"Exit"
)

ESCOLHA=$(printf '%s\n' "${OPCOES[@]}" | fzf --reverse --prompt="GUI Manager > " --height=40% --border --ansi)

case "$ESCOLHA" in
	"Search Game")
		clear
		read -p "Title: " TITLE
		TITLE_ENCODED="${TITLE// /%20}"
		URL="https://thepiratebay0.org/search/$TITLE_ENCODED/1/99/400"
		HTML=$(curl -s "$URL")
		mapfile -t NOMEHUMANO < <(echo "$HTML" | xmllint --html --xpath '//div[@class="detName"]/a/text()' - 2>/dev/null)
		mapfile -t NOMES < <(echo "$HTML" | xmllint --html --xpath '//div[@class="detName"]/a/@href' - 2>/dev/null | grep -oP '[^/]+$' | tr -d '"')
		mapfile -t IDS < <(echo "$HTML" | xmllint --html --xpath '//div[@class="detName"]/a/@href' - 2>/dev/null | grep -oP '/torrent/\K[0-9]+')
		mapfile -t UPLOADERS < <(echo "$HTML" | xmllint --html --xpath '//a[@class="detDesc"]/text()' - 2>/dev/null)
		;;
	"Exit")
		clear
		exit 0
		;;
esac

JOGO_ESCOLHIDO=$(for i in "${!NOMEHUMANO[@]}"; do
  echo "$i) ${NOMEHUMANO[$i]} [${UPLOADERS[$i]}]"
  clear
done | fzf --reverse --prompt="GUI Manager > " --height=40% --border --ansi)

IDX="${JOGO_ESCOLHIDO%%)*}"
NOME_ESCOLHIDO="${NOMES[$IDX]}"
NOME_ESCOLHIDO_ENCODED="${NOME_ESCOLHIDO// /%20}"
ID_ESCOLHIDO="${IDS[$IDX]}"
UPLOADER_ESCOLHIDO="${UPLOADERS[$IDX]}"

URL_FINAL="https://thepiratebay0.org/torrent/$ID_ESCOLHIDO/$NOME_ESCOLHIDO_ENCODED"
clear
echo "$URL_FINAL"
