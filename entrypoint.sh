#!/bin/sh

PACKAGE="phpstan/phpstan"
if test "$INPUT_PHPSTANVERSION" != 'none'; then
  PACKAGE="phpstan/phpstan:$INPUT_PHPSTANVERSION"
fi

if [ "$INPUT_USEBUNDLED" = "0" ]; then
  composer global require $PACKAGE
  PHPSTAN=$HOME/.composer/vendor/bin/phpstan
else
  PHPSTAN="./vendor/bin/phpstan"
fi

if [ "$INPUT_INSTALLCOMPOSER" != "0" ]; then
  if [ ! -d "vendor" ]; then
    composer install
  fi
fi

if [ -n "$INPUT_CONFIGPATH" ]; then
  CONFIG="-c $INPUT_CONFIGPATH"
else
  CONFIG=""
fi

if [ -n "$INPUT_PATHS" ]; then
  for DIR in $INPUT_PATHS; do
    $PHPSTAN analyse $CONFIG "$DIR" --level=$INPUT_LEVEL $INPUT_ARGUMENTS
  done
else
  $PHPSTAN analyse $CONFIG --level=$INPUT_LEVEL $INPUT_ARGUMENTS
fi
