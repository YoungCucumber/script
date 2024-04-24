#!/bin/bash

input_dir=${1:-"input"}
output_dir=${2:-"output"}

#Получение списка файлов в входной директории input_dir
input_files=$(find "$input_dir" -maxdepth 1 -type f)
echo "Список файлов, вложенных во входную директорию"
echo $input_files
echo ""

#Получение списка всех директорий в входной директории input_dir
input_directories=$(find "$input_dir" -maxdepth 1 -type d)
echo "Список директорий, вложенных во входную директорию"
echo $input_directories
echo ""

# Получение списка всех файлов в входной директории
nested_files=$(find "$input_dir" -type f)
echo "Список всех файлов во входной директории"
echo $nested_files
echo ""

copy_file() {
    local src="$1"
    local dest="$2"

    local filename=$(basename -- "$src")
    local filename_no_ext="${filename%.*}"

    local counter=1
    while [ -e "$dest/$filename" ]; do
        filename="$filename_no_ext-$counter.${filename##*.}"
        ((counter++))
    done

    cp "$src" "$dest/$filename"
}

#Копирование с уникальными именами
for file in $nested_files; do
    copy_file "$file" "$output_dir"
done