#!/usr/bin/env bash

FILE=/home/macario/gh-actions-proj/configuring-servers/hosts


if [ -f "$FILE" ]; then
  terraform_output=$(terraform output -json instances_ips)
  echo "$terraform_output" | sed 's/\[//; s/\]//; s/,/\n/g; s/"//g' >> "$FILE"
else
  echo "[servers]" > "$FILE"
  terraform_output=$(terraform output -json instances_ips)
  echo "$terraform_output" | sed 's/\[//; s/\]//; s/,/\n/g; s/"//g' >> "$FILE"
fi


