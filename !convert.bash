#!/bin/bash

#Параметры для FFMPEG
#FFMPEG Parameters
#For constant bitrate
PARAMETERS='-acodec aac -strict -2 -b:a 128k -vcodec libx264 -b:v 10000k -r 25 -ac 2'
#For variable bitrate uncoment this string and comment previous string
#PARAMETERS='-acodec aac -strict -2 -b:a 128k -vcodec libx264 -crf 18 -r 25 -ac 2'

ls | while read FILENAME;
do

#Удаляем из имени файла всё после последней точки, т.е. удаляем расширение файла.
#Чтобы у сконвертированных файлов не было дублирования расширения в названии.
#Delete file extension from filename.
FILENAME_WITHOUT_EXT=$(echo "$FILENAME" | sed 's/\.[^.]*$//');

#Директория в которую будут сохраняться переконвертированные файлы
#The directory where converted files will be saved
OUTPUT="./converted/conv.$FILENAME_WITHOUT_EXT.mp4"

#Расширения файлов, которые будет искать скрипт в корневой папке, а затем конвертировать
#Extensions of files that will search the script in the root folder, and then convert
if [[ $FILENAME = *.mpg || $FILENAME = *.mp4 || $FILENAME = *.mpeg || $FILENAME = *.mxf || $FILENAME = *.mts || $FILENAME = *.mkv ]]
    then
        ffmpeg -hide_banner -i "$FILENAME" $PARAMETERS "$OUTPUT" < /dev/null
fi

done

echo 'Нажмите любую клавишу'
read -n 1
