#!/bin/bash

#usage ./install_script_developer.sh BRANCHNAME
#if no argument specified master branch is used otherwise the branch specified will be fetched

BRANCH='staging';
PHP_EXECUTABLE='php';
CURENT_VERSION='1.9.1';
NEXT_VERSION='1.9.2';


if [ ! -z "$1" ]
  then
    CURENT_VERSION=$1;
fi

if [ ! -z "$2" ]
  then
    NEXT_VERSION=$2;
fi

if [ ! -z "$3" ]
  then
    BRANCH=$3;
fi

if [ ! -z "$4" ]
  then
    PHP_EXECUTABLE=$4;
fi

USERNAME='KindT17';
PASSWORD='K_Tamas17';

modulesWS=(
    "ModulTest3::https://$USERNAME:$PASSWORD@github.com/KindT17/modultest3.git"
)

modules=(
    "ModulTest1::https://$USERNAME:$PASSWORD@github.com/KindT17/modultest1.git"
    "ModulTest2::https://$USERNAME:$PASSWORD@github.com/KindT17/modultest2.git"
)

if [ ! -d  "app/code/Wp" ]
then
    mkdir -p app/code/Wp;
fi

cd app/code/Wp;

for index in "${modules[@]}"
do
    MODULENAME="${index%%::*}"
    GITREPO="${index##*::}"

    mkdir -p $MODULENAME;
    cd $MODULENAME;

    echo "";
    echo "====================== $MODULENAME ======================";

    if [ ! -d '.git' ]; then
        git init;
        git remote add origin $GITREPO
    fi
        git remote set-url origin $GITREPO
        sed -i 's/1.9.0/1.9.1/g' composer.json

    git fetch;
    git checkout $BRANCH;
    git pull origin $BRANCH;
    cd ..;
done

if [ ! -d  "../../code/Ws" ]
then
    mkdir -p ../../code/Ws;
fi

cd ../../code/Ws/;

for contor in "${modulesWS[@]}"
do
    MODULENAME="${contor%%::*}"
    GITREPO="${contor##*::}"

    mkdir -p $MODULENAME;
    cd $MODULENAME;

    echo "";
    echo "====================== $MODULENAME ======================";

    if [ ! -d '.git' ]; then
        git init;
        git remote add origin $GITREPO
    fi
        git remote set-url origin $GITREPO
    git fetch;
    git checkout $BRANCH;
    git pull origin $BRANCH;
    cd ..;
done

cd ../../../../;


echo "DONE";
