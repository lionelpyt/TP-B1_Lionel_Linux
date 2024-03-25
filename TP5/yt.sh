
_youtube_dl="/usr/local/bin/youtube-dl"

destination_folder="/srv/yt/downloads"

if [ ! -d "$destination_folder" ]; then
    echo "Le dossier $destination_folder n'existe pas !"
    exit 1
fi

video_name=$($_youtube_dl --get-filename "$1" | sed 's/\.[^.]*$//')

video_folder="$destination_folder/$video_name"
mkdir -p "$video_folder"

echo "Téléchargement de la vidéo..."
$_youtube_dl -o "$video_folder/$video_name.mp4" "$1" > /dev/null

description_file="$video_folder/description"
echo "Téléchargement de la description..."