# tyba_university

## Getting Started

## Required flutter version

This is the minimum version of flutter needed to run the project

Flutter 3.16.9

## Install dependencies

You must install fvm to handle the different versions of flutter

https://fvm.app/documentation/getting-started/installation

brew tap leoafarias/fvm
brew install fvm

fvm use 3.16.9

The project uses make files to be able to make a dynamic configuration of 
bundle ids and application names, you can install it this way

brew install make

The project uses a dependency to be able to rename the application and to
be able to paint the app with different styles, for this RENAME must be installed

https://pub.dev/packages/rename

fvm flutter pub global activate rename
