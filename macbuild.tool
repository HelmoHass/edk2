#!/bin/bash

BUILDDIR=$(dirname "$0")
pushd "$BUILDDIR" >/dev/null
BUILDDIR=$(pwd)
popd >/dev/null

cd "$BUILDDIR"

prompt() {
  echo "$1"
  if [ "$FORCE_INSTALL" != "1" ]; then
    read -p "Enter [Y]es to continue: " v
    if [ "$v" != "Y" ] && [ "$v" != "y" ]; then
      exit 1
    fi
  fi
}

source edksetup.sh || exit 1

if [ "$SKIP_TESTS" != "1" ]; then
  make -C BaseTools || exit 1
  touch UDK.ready
fi

if [ "$SKIP_BUILD" != "1" ]; then
  if [ "$MODE" = "" ] || [ "$MODE" = "DEBUG" ]; then
    build -a X64 -b DEBUG -t XCODE5 -p MdeModulePkg/MdeModulePkg.dsc -m MdeModulePkg/Universal/Variable/EmuRuntimeDxe/EmuVariableRuntimeDxe.inf || exit 1
  fi

  if [ "$MODE" = "" ] || [ "$MODE" = "RELEASE" ]; then
    build -a X64 -b RELEASE -t XCODE5 -p MdeModulePkg/MdeModulePkg.dsc -m MdeModulePkg/Universal/Variable/EmuRuntimeDxe/EmuVariableRuntimeDxe.inf || exit 1
  fi
fi
# Fat
if [ "$SKIP_BUILD" != "1" ]; then
  if [ "$MODE" = "" ] || [ "$MODE" = "DEBUG" ]; then
build -a X64 -b DEBUG -t XCODE5 -p FatPkg/FatPkg.dsc || exit 1
  fi
if [ "$MODE" = "" ] || [ "$MODE" = "RELEASE" ]; then
build -a X64 -b RELEASE -t XCODE5 -p FatPkg/FatPkg.dsc || exit 1
  fi
fi
cd .. || exit 1
