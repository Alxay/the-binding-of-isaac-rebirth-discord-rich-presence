#!/bin/bash

pid="$(pgrep python -af | grep 'mods/the-binding-of-isaac-rebirth-discord-rich-presence/main.py' | awk '{print $1}')"

if [ -n "$pid" ]; then
    kill "$pid"
    echo "existing process was killed"
fi
sh 'REPENTOGONLauncher/REPENTOGONLauncher.exe'

cd "$(dirname "$0")" || exit 1
./venv/bin/python main.py &

args=("$@")

for i in "${!args[@]}"; do
    if [[ "${args[$i]}" == *"isaac-ng.exe" ]]; then
        args[$i]="${args[$i]/isaac-ng.exe/REPENTOGONLauncher/REPENTOGONLauncher.exe}"
    fi
done

exec "${args[@]}"
