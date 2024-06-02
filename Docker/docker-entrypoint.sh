#!/bin/sh

echo "Starting JMusicBot by Jagrosh https://github.com/jagrosh/MusicBot"
echo "Containerized and updated by Clifford64 https://github.com/clifford64/MusicBot"
echo "Version: $JMB_VERSION"

# Check if config directory exists
if [ ! -d "/jmb/config" ]; then
    echo "Error: Config directory '/jmb/config' not found. Please ensure a volume or directory on the host system is mapped to /jmb/config"
    exit 1
fi

# Check if config file exists
if [ ! -f "/jmb/config/config.txt" ]; then
    # Check if the user has write access to the config directory
    if [ -w "/jmb/config" ]; then
        echo "Downloading config.txt..."
        curl -fsSL -o /jmb/config/config.txt https://github.com/jagrosh/MusicBot/raw/0.4.1/src/main/resources/reference.conf
    else
        echo "Error: '/jmb/config/config.txt' not found and run as user doesn't have write access to download the file automatically. Please update the permissions to the folder or download the file manually from 'https://github.com/jagrosh/MusicBot/raw/0.4.1/src/main/resources/reference.conf'" 
        exit 1
    fi
fi

# Check if the user has read access to the config file
if [ ! -r "/jmb/config/config.txt" ]; then
    echo "Error: Run as user doesn't have permissions to read '/jmb/config/config.txt'. Please update the permissions"
    exit 1
fi


# Run the bot
java -jar -Dconfig=/jmb/config/config.txt -Dnogui=true /jmb/JMusicBot.jar

# Print stopping message and wait before termination
echo "Seems like java stopped... Waiting for 30 seconds before termination..."
echo ""
echo "If you received a warning about 'No Token Provided', please check the config.txt file for the discord token for your server."
sleep 30s
echo "Terminating!"