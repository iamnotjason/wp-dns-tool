## Function name: dns
## Arguments?: Yes, domain or URL
## Purpose: Run the function. It will ask for a domain name. Once provided, it will return the DNS records as shown below.


$ dns

Domain: https://www.wpengine.com/

		Domain Name	 WPENGINE.COM
		Registrar	 ENOM, INC.
		Updated Date	 2014-09-22T21


------------------------------------------------------------------
Domain				Type	Record Found
------------------------------------------------------------------

wpengine.com.                 	NS  	jim.ns.cloudflare.com.
wpengine.com.                 	NS  	kara.ns.cloudflare.com.
wpengine.com.                 	A   	104.16.1.252
wpengine.com.                 	A   	104.16.0.252
www.wpengine.com.             	A   	104.16.0.252
www.wpengine.com.             	A   	104.16.1.252
cdn.wpengine.com.             	CNAME	wpe.wpengine.netdna-cdn.com.
wpe.wpengine.netdna-cdn.com.  	A   	198.232.124.225

====================================================================

dns(){ bold='\033[1m'; red='\x1b[0;31m'; yellow='\x1b[0;33m'; green='\x1b[0;32m'; teal='\x1b[0;36m'; blue='\x1b[0;34m'; purple='\x1b[0;35m'; NC='\x1b[0m'; echo -en "\n${red}Domain: ${NC}"; read dom; dom=$(echo "$dom" | sed "s_[^a-zA-Z0-9.-]__g" | sed -r "s_https?(www\.)?__g" | sed "s,/$,,"); if [[ ! -z $dom ]]; then echo -e "\n$(whois $dom | egrep '(Domain Name: |Registrar: |Updated Date: )' | sort | awk -F':' ' { print $1"\t"$2} ' |  sed 's/^/\t\t/')\n\n\n------------------------------------------------------------------\n${bold}Domain\t\t\t\tType\tRecord Found${NC}\n------------------------------------------------------------------\n\n$(dig $dom -t NS +noall +answer $dom -t A +noall +answer www."$dom" -t A +noall +answer cdn."$dom" +noall +answer -t A | tail -n +4 | awk -v pfblue='\033[34m' -v pfNC='\033[0m' {'printf ("\033[32;1m%30-s\033[0m\t\033[37m%-4s\033[0m\t\033[32;1m%s\033[0m\n", $1, $4, $5)'})\n"; else echo -e "\n${yellow}No domain name was provided.${NC}\n\n"; fi;}; dns
