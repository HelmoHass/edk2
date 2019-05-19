#!/bin/bash

source edksetup.sh
build -a X64 -b RELEASE -t XCODE5 -p MdeModulePkg/MdeModulePkg.dsc -m MdeModulePkg/Universal/Variable/EmuRuntimeDxe/EmuVariableRuntimeDxe.inf
source edksetup.sh
build -a X64 -b DEBUG -t XCODE5 -p MdeModulePkg/MdeModulePkg.dsc -m MdeModulePkg/Universal/Variable/EmuRuntimeDxe/EmuVariableRuntimeDxe.inf