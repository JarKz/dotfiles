devices="$(pactl list sinks short | awk '{print $2}')"

for device in $devices
do
  pactl set-sink-volume "$device" -5%
done
