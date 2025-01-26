#!/bin/bash

# Lade Umgebungsvariablen
source .env
REPO_VERZEICHNIS=$REPO_VERZEICHNIS

# Prüfung, ob Verzeichnis existiert
if [[ ! -d "$REPO_VERZEICHNIS" ]]; then
    echo -e "\033[0;31mDas Verzeichnis $REPO_VERZEICHNIS existiert nicht!\033[0m"
    exit 1
fi

# Ins Repo-Verzeichnis wechseln
cd "$REPO_VERZEICHNIS" || {
    echo -e "\033[0;31mFehler beim Wechsel in das Verzeichnis $REPO_VERZEICHNIS!\033[0m"
    exit 1
}

# Git Pull ausführen
echo -e "\033[0;32mPull aus dem Repository...\033[0m"
pull_output=$(git pull)

if [[ $pull_output == *"Bereits aktuell"* ]]; then
    echo -e "\033[0;33mBereits aktuell.\033[0m"
else
    if [[ $? -eq 0 ]]; then
        echo -e "\033[0;32mPull erfolgreich abgeschlossen!\033[0m"
    else
        echo -e "\033[0;31mPull fehlgeschlagen!\033[0m"
        exit 1
    fi
fi
