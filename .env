#!/bin/bash
ENV_FILE=".env"

if [ ! -f "$ENV_FILE" ]; then
    exit 1
fi

while IFS='=' read -r key value; do
    if [[ "$key" =~ ^#.* ]] || [[ -z "$key" ]]; then
        continue
    fi

    key=$(echo $key | xargs)
    value=$(echo $value | xargs)

    export "$key=$value"
done < "$ENV_FILE"
