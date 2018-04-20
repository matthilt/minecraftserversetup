#!/bin/bash

#Check if the minecraft server is running

RESULT=`ps aux | grep "[m]inecraft_server.jar"`
if [ "${RESULT:-null}" = null ]; then #if the RESULT from the previous command is null
echo "Minecraft Server is not running, not backing up."
exit 1
else

#Let users know of the backup and turn off world saving temporarily
/usr/bin/screen -p 0 -S minecraft -X eval 'stuff "say Server Backup Beginning Now..."\\015save-off\\015save-all\\015'
sleep 3

#Change Directory into home directory
cd /home/###USER###

#do level backup
zip -9 -r backup/Minecraft-Server.zip server
mv -f backup/Minecraft-Server.zip backup/Minecraft-Server-$(date -d "today" +"%Y%m%d").zip

#Let users know the backup is done and re-enable world saving. Also relay the time, because why not.
/usr/bin/screen -p 0 -S minecraft -X eval 'stuff save-on\\015"say Backup complete. World now saving to disk."\\015'

/usr/bin/screen -p 0 -S minecraft -X eval 'stuff "say Beginning Cloud upload of backup"\\015'
azcopy --source backup/Minecraft-Server-$(date -d "today" +"%Y%m%d").zip --destination https://mcserverbackup.blob.core.windows.net/mcserverbackup-container/backups/Minecraft-Server-$(date -d "today" +"%Y%m%d").zip --dest-key lJOLgGK54GBEOPa4apKDtnO7XbJIFvUWESZhMpcilr3jTqC1JNGZSsozfn2mD5AAxGbl5FTgXObcAsHQ04e0cw== --quiet
/usr/bin/screen -p 0 -S minecraft -X eval 'stuff "say Cloud upload of backup complete"\\015'

fi
exit 0
