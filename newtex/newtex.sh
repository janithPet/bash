#!/bin/bash

die () {
    echo >&2 "$@"
    exit 1
}

[ "$#" -eq 2 ] || die "2 arguments required, $# provided"


if [ -d "$2" ]; then
 	die "Directory $2 already exists"
fi

mkdir "$2"
cd "$2"

if [ "$1" == "jmlr" ]; then
	style="jmlr2e"
else
	die "$1 isn't a valid style"
fi

cp "/Volumes/dev/dev/bash/newtex/$style.sty" "./$style.sty"
cp "/Volumes/dev/dev/bash/newtex/main.bib" "./main.bib"
cp "/Volumes/dev/dev/bash/newtex/v0.tex" "./v0.tex"
cp "/Volumes/dev/dev/bash/newtex/.gitignore" "./.gitignore"


gh repo create $2
git init
touch README.md
echo $2 >> README.m
git add README.md
git add .
git commit -m "first commit"
git remote add origin https://github.com/janithPet/$2.git
git push -u origin master
