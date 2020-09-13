#/bin/bash

if [ -f VERSION ]; then
    BASE_STRING=`cat VERSION`
    BASE_LIST=(`echo $BASE_STRING | tr '.' ' '`)
    V_MAJOR=${BASE_LIST[0]}
    V_MINOR=${BASE_LIST[1]}
    V_PATCH=${BASE_LIST[2]}
    echo -e "${NOTICE_FLAG} Current version: ${WHITE}$BASE_STRING"
    V_MINOR=$((V_MINOR + 1))
    V_PATCH=0
    SUGGESTED_VERSION="$V_MAJOR.$V_MINOR.$V_PATCH"
    echo -ne "${QUESTION_FLAG} ${CYAN}Enter a version number [${WHITE}$SUGGESTED_VERSION${CYAN}]: "
    read VERSIONE
    if [ "$VERSIONE" = "" ]; then
        VERSIONE=$SUGGESTED_VERSION
    fi
    # deve escludere se' stessa !!
    find . -not -path "./.git/*" -not -path "./new-version.sh" -type f -exec sed -i "s/@version .*$/@version     ${VERSIONE}/" {} \;
    git add --all
    git commit -m "Aggiornato il numero di versione"
    git status

fi

