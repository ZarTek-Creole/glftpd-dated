# glftpd-dated

## English

This Bash script is designed to automate the creation of dated directories and corresponding symbolic links in a glFTPd environment. It follows a defined configuration structure to handle various sections, each specifying a source directory, a destination directory, and a time interval (day, week, month, year). The script ensures that the glFTPd environment is properly configured before proceeding with the creation of directories and links, by checking the existence of the glFTPd root directory and the logging file. For each configured section, the script creates a dated directory according to the specified interval, creates a symbolic link "_root" pointing to an appropriate higher level for easy access, updates or creates a new symbolic link for the destination directory, and logs the action in the glFTPd logging file. This process facilitates the management and access to files organized by date in a glFTPd environment, while automating maintenance and improving file management efficiency.

## Français

Ce script Bash est conçu pour automatiser la création de répertoires datés et de liens symboliques correspondants dans un environnement glFTPd. Il suit une structure de configuration définie pour traiter diverses sections, chacune spécifiant un répertoire source, un répertoire de destination et un intervalle temporel (jour, semaine, mois, année). Le script s'assure que l'environnement glFTPd est correctement configuré avant de procéder à la création de répertoires et de liens, en vérifiant l'existence du répertoire racine glFTPd et du fichier de journalisation. Pour chaque section configurée, le script crée un répertoire daté selon l'intervalle spécifié, crée un lien symbolique "_root" pointant vers un niveau supérieur approprié pour un accès facile, met à jour ou crée un nouveau lien symbolique pour le répertoire de destination, et enregistre l'action dans le fichier de journalisation glFTPd. Ce processus facilite la gestion et l'accès aux fichiers organisés par date dans un environnement glFTPd, tout en automatisant la maintenance et en améliorant l'efficacité de la gestion des fichiers.
