#!/usr/bin/env bash

TOKYO=$(TZ=Asia/Tokyo date '+%H:%M')
MEXICO=$(TZ=America/Mexico_City date '+%H:%M')

printf '{"text":"🇯🇵 %s 🇲🇽 %s","tooltip":"Tokyo: %s\\nMexico City: %s"}\n' \
    "$TOKYO" "$MEXICO" "$TOKYO" "$MEXICO"
