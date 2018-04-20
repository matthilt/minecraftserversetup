# minecraftserversetup

If Google Compute:  https://cloud.google.com/solutions/gaming/minecraft-server

## Create Ubuntu VM with user minecraft

#Run Updates and Install Required Hardware

sudo timedatectl set-timezone America/New_York

sudo apt-get update && sudo apt-get -y upgrade
sudo apt-get -y install default-jdk screen zip unzip golang-go

#Download and setup gdrive
wget -O gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA
sudo chmod u+x gdrive
./gdrive about
  Sets up connection to Google drive for inital download of previous backup as well as setting up new backup

#Download backed up server
./gdrive list #Lists files on Google Drive
./gdrive download ##ID## Use ID of file not filename
unzip Minecraft-Server-#####.zip

#Downloads Service file and sets up service
sudo wget -O /etc/systemd/system/minecraft.service https://github.com/matthilt/minecraftserversetup/raw/master/minecraft.service
sudo systemctl enable minecraft

#Install .NET for Azure Copy
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/microsoft-ubuntu-xenial-prod xenial main" > /etc/apt/sources.list.d/dotnetdev.list'

mkdir backup
lwget -O backup.sh https://github.com/matthilt/minecraftserversetup/raw/master/backup.sh
chmod u+x backup.sh

wget -O cron.file https://github.com/matthilt/minecraftserversetup/raw/master/cron.file
crontab cron.file


