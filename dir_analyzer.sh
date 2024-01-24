#!/bin/bash
# Prompt the user to enter a directory
read -p "Enter a directory to analyze(e.g.../home/kali/Documents): " path
if [ -d $path ] || [ -f $path ]; then
     for file in "$path"/*; do
  # Get file basename
  basename=$(basename "$file")

  # Get file extension
  ext="${file##*.}"

  # Analyze files based on extension
  case "$ext" in
    # Images
    jpg|jpeg|png|tiff|bmp)
      echo "Analyzing image: $basename"
      exiftool "$file"
      ;;
    # Audio/Video
    mp3|mp4|avi|mkv)
      echo "Analyzing multimedia: $basename"
      mediainfo "$file"
      ;;
    # Text
    txt|markdown|pdf)
      echo "Analyzing text file: $basename"
      cat "$file"
      ;;
    # Binaries
    exe|dll)
      echo "Analyzing binary: $basename"
      strings "$file"
      ;;
    # Network capture files (pcap)
    pcap)
      echo "Analyzing network capture: $basename"
      tcpdump -r "$file"
      ;;
    # Default case
    *)
      echo "Skipping unknown file: $basename"
      ;;
  esac

  echo "--------------------"
done

echo "Finished analyzing files in $path."
     
else
    echo "File Does Not Exist"
fi
