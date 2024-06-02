#!/bin/bash

# Fonction pour afficher une barre de progression avec couleur
progress_bar() {
    local total_duration=${1}
    local interval=0.05  # Intervalle réduit pour une mise à jour plus rapide
    local progress=0
    local total_progress=100
    
    while [ $progress -le $total_progress ]; do
        local filled=$((progress))
        local empty=$((50 - filled / 2))
        printf "\r\033[0;32m["
        for ((i=0; i<filled/2; i++)); do
            printf "█"
        done
        for ((i=0; i<empty; i++)); do
            printf " "
        done
        printf "] %3d%%\033[0m" $((progress))
        sleep $interval
        ((progress+=1))
    done
    printf "\n"
}

# Chemin du répertoire personnel de l'utilisateur
USER_HOME=$(eval echo ~)

# Durée totale en secondes pour l'installation
total_duration=5  # Ajuste cette valeur pour changer la vitesse de la barre de progression

# Initialiser la barre de progression en arrière-plan
progress_bar $total_duration &

# Créer un nouveau dossier dans le répertoire personnel de l'utilisateur
mkdir -p "$USER_HOME/FastStartApp"
sleep 1  # Simuler une durée de traitement

# Déplacer l'image dans le nouveau dossier
cp fsa.png "$USER_HOME/FastStartApp"
sleep 1  # Simuler une durée de traitement

# Déplacer le fichier jar dans le nouveau dossier
cp ./FastStartApp-1.0.jar "$USER_HOME/FastStartApp"
sleep 1  # Simuler une durée de traitement

# Créer le fichier .desktop avec le chemin correct
cat <<EOL > "$USER_HOME/Bureau/FSA.desktop"
[Desktop Entry]
Version=1.0
Type=Application
Name=FastStartApp
Comment=Lancer l'application Java avec JavaFX
Exec=java --module-path /usr/share/openjfx/lib --add-modules javafx.controls,javafx.fxml -jar $USER_HOME/FastStartApp/FastStartApp-1.0.jar
Icon=$USER_HOME/FastStartApp/fsa.png
Terminal=false
EOL
sleep 1  # Simuler une durée de traitement

# Rendre le fichier .desktop exécutable
chmod +x "$USER_HOME/Bureau/FSA.desktop"
sleep 1  # Simuler une durée de traitement

# Attendre que la barre de progression finisse
wait

echo "Installation terminée avec succès !"
