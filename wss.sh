#!/bin/bash

# Terminal color's

red=$'\e[1;31m'
grn=$'\e[1;32m'
blu=$'\e[1;34m'
end=$'\e[0m'

# Services

COMMOM=('FTP:20' 'SSH:22' 'Telnet:23' 'SMTP:25' 'WHOIS:43' 'DNS:53' 'DHC:67' 'HTTP:80' 'POP3:110' 'SNMP:161' 'HTTPS:443' 'SMTP:587')
DATABASES=('MySQL:3306' 'OracleDB:1521' 'PostgreSQL:5432' 'Firebird:3050' 'MongoDB:27017')

# Function

function wss() {
  echo "${blu}**       **  ********  ********
/**      /** **//////  **////// 
/**   *  /**/**       /**       
/**  *** /**/*********/*********
/** **/**/**////////**////////**
/**** //****       /**       /**
/**/   ///** ********  ******** 
//       // ////////  ////////  ${end}"

  echo -e "\n${blu}WSS - Web Services Scanner v0.1${end}"
  echo "${blu}(https://github.com/rafaelszago/wss.git)${end}"

  if [ "$1" != "" ]; then
    HOST=$1

    if [ "$2" != "" ]; then
      case $2 in 
      
      # List database service's
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

        # List all commom service's
        -a)
          echo -e "\n${grn}Searching for all services in ${HOST}...${end}\n"

          # Init scan
          for I in ${COMMOM[*]}; do
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