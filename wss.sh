#!/bin/bash

# Terminal color's

red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
end=$'\e[0m'

# Services

SERVICES=('FTP:20' 'SSH:22' 'Telnet:23' 'SMTP:25' 'WHOIS:43' 'DNS:53' 'DHCP_server:67' 'DHCP_client:68' 'HTTP:80' 'POP3:110' 'IRC:113' 'SNMP:161' 'IRC:194' 'LDAP:389' 'HTTPS:443' 'SMTP:587' 'CUPS:631' 'Webservice:8080')
DATABASES=('MySQL:3306' 'OracleDB:1521' 'PostgreSQL:5432' 'Firebird:3050' 'MongoDB:27017')

# Function

function wss() {
  echo ""
  echo "${blu}//${end}"
  echo "${blu}// WSS - Web Service Scanner v0.1${end}"
  echo "${blu}// by Rafael Zago (https://github.com/rafaelszago)${end}"
  echo "${blu}//${end}"

  if [ "$1" != "" ]; then
    HOST=$1

    if [ "$2" != "" ]; then
      case $2 in 
        -d)
          echo -e "\n${grn}Searching for databases in ${HOST}...${end}\n"

          # Init scan
          for I in ${DATABASES[*]}; do
            PORT=$(cut -d ":" -f 2 <<< ${I})
            SERVICE=$(cut -d ":" -f 1 <<< ${I})
            STATUS=$(nmap -p ${PORT} ${HOST} | grep "open")
            if [ -n "$STATUS" ]; then
              echo "${blu}${SERVICE} (${PORT}):${end} ${grn}Open${end}"
            else
              echo "${blu}${SERVICE} (${PORT}): ${end}${red}Closed${end}"
            fi
          done;
          # Scan end's
          ;;
        -a)
          echo -e "\n${grn}Searching for all services in ${HOST}...${end}\n"

          # Init scan
          for I in ${SERVICES[*]}; do
            PORT=$(cut -d ":" -f 2 <<< ${I})
            SERVICE=$(cut -d ":" -f 1 <<< ${I})
            STATUS=$(nmap -p ${PORT} ${HOST} | grep "open")
            if [ -n "$STATUS" ]; then
              echo "${blu}${SERVICE} (${PORT}):${end} ${grn}Open${end}"
            else
              echo "${blu}${SERVICE} (${PORT}): ${end}${red}Closed${end}"
            fi
          done;
          # Scan end's
          ;;
      esac
    else
      echo -e "\n${red}ERROR: type some argument.${end}\n"
    fi
  else
    echo -e "\n${red}ERROR: type some taget host.${end}\n"
  fi
}