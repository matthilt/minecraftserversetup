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

#do level backup
zip -9 -r /home/###USER###/backup/Minecraft-Server.zip /home/###USER###/server
mv -f /home/###USER###/backup/Minecraft-Server.zip /home/###USER###/backup/Minecraft-Server-$(date -d "today" +"%Y%m%d").zip

#Let users know the backup is done and re-enable world saving. Also relay the time, because why not.
/usr/bin/screen -p 0 -S minecraft -X eval 'stuff save-on\\015"say Backup complete. World now saving to disk."\\015'

/usr/bin/screen -p 0 -S minecraft -X eval 'stuff "say Beginning Cloud upload of backup"\\015'
/home/###USER###/gdrive upload -p 1YoH2OH8sTkHNIO6s4XjG7x6zp1KxGJbt backup/Minecraft-Server-$(date -d "today" +"%Y%m%d").zip
/usr/bin/screen -p 0 -S minecraft -X eval 'stuff "say Cloud upload of backup complete"\\015'

fi
exit 0
