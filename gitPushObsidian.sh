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

# Status überprüfen
if [[ -n $(git status --porcelain) ]]; then
    echo -e "\033[0;34mÄnderungen erkannt. Vorbereitung zum Commit und Push...\033[0m"

    # Alle Änderungen stagen
    git add . || {
        echo -e "\033[0;31mFehler beim Hinzufügen der Änderungen!\033[0m"
        exit 1
    }

    # Commit erstellen
    TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
    git commit -m "Automatischer Commit am $TIMESTAMP" || {
        echo -e "\033[0;31mFehler beim Erstellen des Commits!\033[0m"
        exit 1
    }

    # Push durchführen
    echo -e "\033[0;32mÄnderungen werden ins Remote-Repository gepusht...\033[0m"
    if git push; then
        echo -e "\033[0;34mPush erfolgreich!\033[0m"
    else
        echo -e "\033[0;31mPush fehlgeschlagen!\033[0m"
        exit 1
    fi
else
    echo -e "\033[0;34mKeine Änderungen zum Commiten gefunden.\033[0m"
fi
