fenda="Fenda R30BT"
headphones="External Headphones"

currentOutputDevice=$(/opt/homebrew/bin/SwitchAudioSource -c)

if [ "$currentOutputDevice" = "$fenda" ]; then
    /opt/homebrew/bin/SwitchAudioSource -s "$headphones"
else
    /opt/homebrew/bin/SwitchAudioSource -s "$fenda"
fi
