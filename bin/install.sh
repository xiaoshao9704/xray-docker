#!/bin/sh
set -e

if [ "$(uname)" != "Linux" ]
then
  echo "error: This operating system is not supported."
  exit 1
fi

set_machine() {
  case "$(uname -m)" in
    'i386' | 'i686')
      MACHINE='32'
      ;;
    'amd64' | 'x86_64')
      MACHINE='64'
      ;;
    'armv5tel')
      MACHINE='arm32-v5'
      ;;
    'armv6l')
      MACHINE='arm32-v6'
      grep Features /proc/cpuinfo | grep -qw 'vfp' || MACHINE='arm32-v5'
      ;;
    'armv7' | 'armv7l')
      MACHINE='arm32-v7a'
      grep Features /proc/cpuinfo | grep -qw 'vfp' || MACHINE='arm32-v5'
      ;;
    'armv8' | 'aarch64')
      MACHINE='arm64-v8a'
      ;;
    'mips')
      MACHINE='mips32'
      ;;
    'mipsle')
      MACHINE='mips32le'
      ;;
    'mips64')
      MACHINE='mips64'
      ;;
    'mips64le')
      MACHINE='mips64le'
      ;;
    'ppc64')
      MACHINE='ppc64'
      ;;
    'ppc64le')
      MACHINE='ppc64le'
      ;;
    'riscv64')
      MACHINE='riscv64'
      ;;
    's390x')
      MACHINE='s390x'
      ;;
    *)
      echo "error: The architecture is not supported."
      exit 1
      ;;
  esac
  echo "MACHINE:$MACHINE"
}

set_download_url() {
  DOWNLOAD_URL=`wget -q -O - https://api.github.com/repos/XTLS/Xray-core/releases/latest | grep browser_download_url | egrep -o "http(.*?)/Xray-linux-${MACHINE}.zip" | head -n 1`
  echo "DOWNLOAD_URL:$DOWNLOAD_URL"
}

install_xray() {
  echo "install xray start"
  wget -O /xray/xray-core.zip $DOWNLOAD_URL
  echo "install xray done"
}

unzip_xray() {
  echo "unzip xray start"
  unzip -d /xray/xray-core /xray/xray-core.zip
  rm -rf /xray/xray-core.zip
  echo "unzip xray stop"
}

set_nginx() {
  mkdir -p /run/nginx
}

set_machine
set_download_url
install_xray
unzip_xray
set_nginx