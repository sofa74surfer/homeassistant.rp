#!/bin/bash

rotseepark_up=$1
rotseepark_ftp=$2

# Array mit den Dateipfaden
files=(
    "/share/rotseepark.ch/status.txt"
    "/share/rotseepark.ch/status.jpg"
    "/share/rotseepark.ch/index.php"
    "/share/rotseepark.ch/betriebsmeldungen.txt"
    "/share/rotseepark.ch/bilanz.csv"
    "/share/rotseepark.ch/bilanz.new.csv"
    "/share/rotseepark.ch/bilanz.php"
    "/share/rotseepark.ch/bilanz_nojs.php"
    "/share/rotseepark.ch/bilanz_nojs.test.php"
    "/share/rotseepark.ch/dashboard.php"
    "/share/rotseepark.ch/dashboard_nojs.php"
    "/share/rotseepark.ch/gebaudemeldungen.txt"
    "/share/rotseepark.ch/allgemein-1.txt"
    "/share/rotseepark.ch/allgemein-2.txt"
    "/share/rotseepark.ch/haus19-1.txt"
    "/share/rotseepark.ch/haus19-2.txt"
    "/share/rotseepark.ch/haus21-1.txt"
    "/share/rotseepark.ch/haus21-2.txt"
    "/share/rotseepark.ch/haus23-1.txt"
    "/share/rotseepark.ch/haus23-2.txt"
    "/share/rotseepark.ch/haus25-1.txt"
    "/share/rotseepark.ch/haus25-2.txt"
    "/share/rotseepark.ch/hijack.html"
)

# Funktion zum Überprüfen und Hochladen der Datei
upload_if_modified() {
    local file=$1
    # Prüfen, ob die Datei in den letzten 6 Minuten geändert wurde
    if find "$file" -type f -mmin -6 | grep -q "$file"; then
        echo "Uploading $file..."
        curl -T "$file" -u "${rotseepark_up}" "${rotseepark_ftp}"
    else
        echo "No recent changes to $file. Skipping upload."
    fi
}

# Überprüfen und Hochladen der Dateien im Array
for file in "${files[@]}"; do
    upload_if_modified "$file"
done
