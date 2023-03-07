#!/bin/bash

srcdir="$PWD"
name="deploy"
cmd="rsync -rv"

# relative paths wheee
sources=( 
    "index.html"
    "style.css"
    "services/index.html"
    "blog/index.html"
    "contact/index.html"
    "contact/donate.html"
    "portfolio/index.html"
    "blog/blog.css"
    "blog/imperfect.html"
    "blog/better.html"
    "blog/template.html"
    "blog/bullet.html"
    "blog/twoslowdancers.html"
    "portfolio/res/"
    "portfolio/sites/"
    "icon.css"
    "img.svg"
    "assets/fonts/cmunit.eot"
    "assets/fonts/cmunit.svg"
    "assets/fonts/cmunit.ttf"
    "assets/fonts/cmunit.woff"
    "assets/fonts/cmuntb.eot"
    "assets/fonts/cmuntb.svg"
    "assets/fonts/cmuntb.ttf"
    "assets/fonts/cmuntb.woff"
    "assets/fonts/cmuntt.eot"
    "assets/fonts/cmuntt.svg"
    "assets/fonts/cmuntt.ttf"
    "assets/fonts/cmuntt.woff"
    "assets/fonts/cmuntx.eot"
    "assets/fonts/cmuntx.svg"
    "assets/fonts/cmuntx.ttf"
    "assets/fonts/cmuntx.woff"
    "assets/fonts/OFL.txt"
    "assets/fonts/typewriter.css"
)

echo "Checking sources..."

for src in "${sources[@]}"; do
    if [[ -f "$src" ]] || [[ -d "$src" ]]; then
        echo "Found $src..."
    else
        echo "ERROR: file not found: $src"
        exit 1
    fi
done

if [[ -z "$1" ]]; then
    echo "$name: No destination provided."
    exit 1
else
    if ! [[ -d "$1" ]]; then
        echo "$name: No such directory: $1"
        exit 1
    fi
fi

destdir="$1"

if [[ $2 == "--dry-run" ]]; then
    cmd="echo"
    echo "Dry run: won't change files"
fi

for src in "${sources[@]}"; do
    if ! diff -s "$srcdir/$src" "$1/$src" > /dev/null 2>&1; then
        echo "Updating $src..."
        $cmd "$srcdir/$src" "$1/$src"
    else
        echo "$src not modified, skipping..."
    fi
done