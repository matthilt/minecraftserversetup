# minecraftserversetup
## Create Ubuntu VM with user minecraft

sudo apt update
sudo apt upgrade
sudo apt-get install default-jdk screen zip unzip gulang-go
mkdir server
wget -O gdrive https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA
sudo chmod +x gdrive
./gdrive about
  Sets up connection to Google drive for inital download of previous backup as well as setting up new backup

./gdrive list #Lists files on Google Drive
./gdrive download ##ID## Use ID of file not filename

unzip Minecraft-Server-#####.zip

