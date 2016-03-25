dns(){ bold='\033[1m'; red='\x1b[0;31m'; yellow='\x1b[0;33m'; green='\x1b[0;32m'; teal='\x1b[0;36m'; blue='\x1b[0;34m'; purple='\x1b[0;35m'; NC='\x1b[0m'; if [[ ! -z "$1" ]]; then dom="$1"; else echo -en "\n${red}Domain: ${NC}"; read dom; fi; if [[ ! -z $dom ]]; then echo -e "\n$(whois =$dom | egrep --color=always '(Domain Name: |Registrar: |Updated Date: )' | sort | awk -F':' ' { print $1" "$2} ')\n\n------------------------------------------------------------------\n${bold}Domain\t\t\t\tType\tRecord Found${NC}\n------------------------------------------------------------------\n\n$(dig $dom -t NS +noall +answer $dom -t A +noall +answer www."$dom" -t A +noall +answer cdn."$dom" +noall +answer -t A | tail -n +4 | awk {'printf ("\033[32;1m%30-s\033[0m\t\033[37m%-4s\033[0m\t\033[32;1m%s\033[0m\n", $1, $4, $5)'})\n"; else echo -e "\n${yellow}No domain name was provided.${NC}\n\n"; fi;}; 
