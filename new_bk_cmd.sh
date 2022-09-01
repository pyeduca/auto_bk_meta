#!/bin/bash

# Direcion actual (donde esta el key pair) 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

dirAct=$PWD
dateAuxServer=$(date +%d-%m-%Y)
dateAuxDrive=$(date +%Y-%m-%Y)_cms

# dir_path="~/Escritorio"
drive_path=/run/user/1000/gvfs/google-drive:host=paraguayeduca.org,user=tecnologia/1wYI0TsN8jle-08sO4elJnSUVOXZCMhvO
mkdir ~/backupReport/$dateAuxServer
bkFuntion() {
	cd "$drive_path/$dateAuxServer" 
	echo "Generando archivo pg_dump en la capeta backup - $(date "+%d-%m-%Y_%H:%M:%S")" >> ./CMS_backupReport_$(date "+%d-%m-%Y").txt
	sudo pg_dump -U meta -h localhost -F c -b -v -f ~/backupReport/$dateAuxServer/$(date +%Y-%m-%d)_cms.backup meta
	echo "Generar tar - $(date "+%d-%m-%Y_%H:%M:%S")" >> ./CMS_backupReport_$(date "+%d-%m-%Y").txt
	tar -zcvf $(date +%Y-%m-%d)_cms.tar.gz -C ~/backupReport/$dateAuxServer ~/paraguayeduca-django/media
}

echo "----------------------------------------------------------------------"
echo "------------------------Inico de Backup de CMS------------------------" >> ./CMS_backupReport_$(date "+%d-%m-%Y").txt
echo "Inicio de backup. Servidores detenidos - $(date "+%d-%m-%Y_%H:%M:%S")"  >> ./CMS_backupReport_$(date "+%d-%m-%Y").txt

sudo service nginx stop
sudo supervisorctl stop all 

if [ -d "$drive_path/$dateAuxServer" ]
then
	echo "existe"
	# tar -czvf $dateAuxServer/$dateAuxDrive.tar.gz --absolute-names ~/backupReport/estoEsTodo.txt
	# tar -cvzf sampleArch-rvfive.tar.gz --absolute-names ~/backupReport/24Enero2022 ~/paraguayeduca-django/media
	bkFuntion
else 
	echo " no existe"
	mkdir "$drive_path/$dateAuxServer"
	bkFuntion
fi


echo "Montando ngix - $(date "+%d-%m-%Y_%H:%M:%S")" >> ./CMS_backupReport_$(date "+%d-%m-%Y").txt
sudo service nginx start
sudo supervisorctl start all
echo "ngix Montado - $(date "+%d-%m-%Y_%H:%M:%S")" >> ./CMS_backupReport_$(date "+%d-%m-%Y").txt
