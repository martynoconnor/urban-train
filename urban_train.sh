#!/bin/bash
clear
script_start=`date +%s`
echo "Firewall country blocker script"
echo
echo "Checking for /etc/iptables directory"
echo
# Check if directory exists, do nothing if it does exist.
if [ -d "/etc/iptables" ]; then
  echo "The directory exists"
fi

# Check if directory exists, create it if not.
if [ -d "/etc/iptables" ]; then
  mkdir -p /etc/iptables
fi

echo

# Crude way to flush firewall rules
echo "Bringing down firewall..."
echo
service iptables stop &>/dev/null
echo "Bringing firewall back up..."
service iptables start &>/dev/null
echo
# Allow any established connections
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Allow SSH from within the LAN - Change the value below if your network isn't 192.168.1.0/24
iptables -A INPUT -p tcp --dport 22 -s 192.168.1.0/24 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT

# Begin blocking scripts:

echo "Blocking China..."
echo "#################"
echo "This may take a while, China has a lot of IPs"
startchina=`date +%s`
# This one will be commented for info, the others will not.
ipset -N china hash:net
# remove any old list that might exist from previous runs of this script
rm /etc/iptables/cn.zone
# Pull the latest IP set for China
wget -P . http://www.ipdeny.com/ipblocks/data/countries/cn.zone -O /etc/iptables/cn.zone &>/dev/null
# Add each IP address from the downloaded list into the ipset 'china'
for i in $(cat /etc/iptables/cn.zone ); do ipset -A china $i; done
# Create firewall rule based on the set
iptables -A INPUT -p tcp -m set --match-set china src -j DROP
endchina=`date +%s`
china_runtime=$((endchina-startchina))
echo "Time to ban China : " $china_runtime " seconds"
echo

echo "Blocking Russia..."
echo "##################"
startrussia=`date +%s`
ipset -N russia hash:net
rm /etc/iptables/ru.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/ru.zone -O /etc/iptables/ru.zone &>/dev/null
for i in $(cat /etc/iptables/ru.zone ); do ipset -A russia $i; done
iptables -A INPUT -p tcp -m set --match-set russia src -j DROP
endrussia=`date +%s`
russia_runtime=$((endrussia-startrussia))
echo "Time to ban Russia : " $russia_runtime " seconds"
echo

echo "Blocking Israel..."
echo "##################"
startisrael=`date +%s`
ipset -N israel hash:net
rm /etc/iptables/il.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/il.zone -O /etc/iptables/il.zone &>/dev/null
for i in $(cat /etc/iptables/il.zone ); do ipset -A israel $i; done
iptables -A INPUT -p tcp -m set --match-set israel src -j DROP
endisrael=`date +%s`
israel_runtime=$((endisrael-startisrael))
echo "Time to ban Israel : " $israel_runtime " seconds"
echo

echo "Blocking Kazakhstan..."
echo "######################"
startkazak=`date +%s`
ipset -N kazakhstan hash:net
rm /etc/iptables/kz.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/kz.zone -O /etc/iptables/kz.zone &>/dev/null
for i in $(cat /etc/iptables/kz.zone ); do ipset -A kazakhstan $i; done
iptables -A INPUT -p tcp -m set --match-set russia src -j DROP
endkazak=`date +%s`
kazak_runtime=$((endkazak-startkazak))
echo "Time to ban Kazakhstan : " $kazak_runtime " seconds"
echo 

echo "Blocking Poland..."
echo "##################"
startpoland=`date +%s`
ipset -N poland hash:net
rm /etc/iptables/pl.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/pl.zone -O /etc/iptables/pl.zone &>/dev/null
for i in $(cat /etc/iptables/pl.zone ); do ipset -A poland $i; done
iptables -A INPUT -p tcp -m set --match-set poland src -j DROP
endpoland=`date +%s`
poland_runtime=$((endpoland-startpoland))
echo "Time to ban Poland : " $poland_runtime " seconds"
echo 

echo "Blocking Syria..."
echo "#################"
startsyria=`date +%s`
ipset -N syria hash:net
rm /etc/iptables/sy.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/sy.zone -O /etc/iptables/sy.zone &>/dev/null
for i in $(cat /etc/iptables/sy.zone ); do ipset -A syria $i; done
iptables -A INPUT -p tcp -m set --match-set syria src -j DROP
endsyria=`date +%s`
syria_runtime=$((endsyria-startsyria))
echo "Time to ban Syria: " $syria_runtime " seconds"
echo

echo "Blocking Taiwan..."
echo "##################"
starttaiwan=`date +%s`
ipset -N taiwan hash:net
rm /etc/iptables/tw.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/tw.zone -O /etc/iptables/tw.zone &>/dev/null
for i in $(cat /etc/iptables/tw.zone ); do ipset -A taiwan $i; done
iptables -A INPUT -p tcp -m set --match-set taiwan src -j DROP
endtaiwan=`date +%s`
taiwan_runtime=$((endtaiwan-starttaiwan))
echo "Time to ban Taiwan : " $taiwan_runtime " seconds"
echo

echo "Blocking Tajikistan..."
echo "######################"
tajikstart=`date +%s`
ipset -N tajikistan hash:net
rm /etc/iptables/tj.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/tj.zone -O /etc/iptables/tj.zone &>/dev/null
for i in $(cat /etc/iptables/tj.zone ); do ipset -A tajikistan $i; done
iptables -A INPUT -p tcp -m set --match-set tajikistan src -j DROP
tajikend=`date +%s`
tajik_runtime=$((tajikend-tajikstart))
echo "Time to ban Tajikistan : " $tajik_runtime " seconds"
echo

echo "Blocking Turkmenistan..."
echo "########################"
turkmenstart=`date +%s`
ipset -N turkmenistan hash:net
rm /etc/iptables/tm.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/tm.zone -O /etc/iptables/tm.zone &>/dev/null
for i in $(cat /etc/iptables/tm.zone ); do ipset -A turkmenistan $i; done
iptables -A INPUT -p tcp -m set --match-set turkmenistan src -j DROP
turkmenend=`date +%s`
turkmen_runtime=$((turkmenend-turkmenstart))
echo "Time to ban Turkmenistan : " $turkmen_runtime " seconds"
echo

echo "Blocking Ukraine..."
echo "###################"
ukrainestart=`date +%s`
ipset -N ukraine hash:net
rm /etc/iptables/ua.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/ua.zone -O /etc/iptables/ua.zone &>/dev/null
for i in $(cat /etc/iptables/ua.zone ); do ipset -A ukraine $i; done
iptables -A INPUT -p tcp -m set --match-set ukraine src -j DROP
ukraineend=`date +%s`
ukraine_runtime=$((ukraineend-ukrainestart))
echo "Time to ban Ukraine : " $ukraine_runtime " seconds"
echo

echo "Blocking Uzbekistan..."
echo "######################"
uzbekstart=`date +%s`
ipset -N uzbekistan hash:net
rm /etc/iptables/uz.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/uz.zone -O /etc/iptables/uz.zone &>/dev/null
for i in $(cat /etc/iptables/uz.zone ); do ipset -A uzbekistan $i; done
iptables -A INPUT -p tcp -m set --match-set uzbekistan src -j DROP
uzbekend=`date +%s`
ukbek_runtime=$((uzbekend-uzbekstart))
echo "Time to ban Uzbekistan : " $uzbek_runtime " seconds"
echo

echo "Blocking Iran..."
echo "################"
iranstart=`date +%s`
ipset -N iran hash:net
rm /etc/iptables/ir.zone
wget -P . http://www.ipdeny.com/ipblocks/data/countries/ir.zone -O /etc/iptables/ir.zone &>/dev/null
for i in $(cat /etc/iptables/ir.zone ); do ipset -A iran $i; done
iptables -A INPUT -p tcp -m set --match-set iran src -j DROP
iranend=`date +%s`
iran_runtime=$((iranend-iranstart))
echo "Time to ban Iran : " $iran_runtime " seconds"
echo

echo "Blocking Amazon Web Services..."
echo "###############################"
AWS_start=`date +%s`
# This isn't my code, I borrowed it from somewhere and cant remember where
# Create the AWS iptables chain if it doesn't exist
iptables -n --list AWS >/dev/null 2>&1 \
    || (iptables -N AWS && iptables -I INPUT 1 -j AWS)

# Flush the existing AWS iptables chain
iptables -F AWS

# Get list of IP ranges
#
# First we use curl to grab the official list of ranges from Amazon. The -s
# prevents extraneous output from curl, and the -L makes it follow redirects.
#
# The ranges are passed to jq, a JSON parser. The -r makes jq output raw data
# without quotes. We only need the list of prefixes, so we discard everything
# else.
RANGES=$(curl -s -L https://ip-ranges.amazonaws.com/ip-ranges.json \
    | jq -r '.prefixes[].ip_prefix' \
    | sort -Vu)

# Loop through the ranges, adding each to iptables
while read -r line; do
    iptables -A AWS -s "$line" -j REJECT
done <<< "$RANGES"
AWS_end=`date +%s`
AWS_runtime=$((AWS_end-AWS_start))
echo "Time to ban AWS : " $AWS_runtime " seconds"
echo

echo "Allowing expected traffic..."
echo "############################"
echo
# Allow loopback connections
iptables -A INPUT -i lo -s 127.0.0.0/8 -j ACCEPT
iptables -A OUTPUT -o lo -d 127.0.0.0/8 -j ACCEPT

echo "Allowing HTTP"
echo "#############"
# Allow HTTP - You only need this if you are running a web server. Be aware this is not encrypted.
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

echo "Allowing HTTPS"
echo "##############"
# Allow HTTPS - You only need this if you are running a web server.
iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

echo "Allowing SMTP"
echo "#############"
# Allow SMTP - You only need this if you are running a mail server. Be aware this is not encrypted. 
iptables -A INPUT -p tcp --dport 25 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

echo "Allowing IMAP"
echo "#############"
# Allow IMAP - You only need this if you are running an IMAP mail server. Be aware this is not encrypted.
iptables -A INPUT -p tcp --dport 143 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

echo "Allowing IMAPS"
echo "##############"
# Allow IMAPS - You only need this if you are running an IMAP mail server.
iptables -A INPUT -p tcp --dport 993 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

echo "Allowing POP3"
echo "#############"
# Allow POP3 - You only need this if you are running a mail server. Be aware this is not encrypted.
iptables -A INPUT -p tcp --dport 110 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

echo "Allowing POP3S"
echo "##############"
# Allow POP3S - You only need this if you are runnign a mail server. 
iptables -A INPUT -p tcp --dport 995 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT

echo "Script completed. You can check your firewall now by running the command iptables -L -n"
script_end=`date +%s`
script_runtime=$((script_end-script_start))
echo "Total runtime was " $script_runtime " seconds"
#echo "Implementing all that..."
#/sbin/iptables-restore < /etc/iptables/firewall.rules
