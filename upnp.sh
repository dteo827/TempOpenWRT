#!/bin/ash
# Sabai Technology - Apache v2 licence
# Copyright 2014 Sabai Technology
#this script developed to set three variables to be 
#on or off according to user input 
#As well as specify the start and end of the internal and external ports

#Used Variables 

enable=$(uci get sabai.upnp.enable);
clean=$(uci get sabai.upnp.clean);
secure=$(uci get sabai.upnp.secure);
intmin=$(uci get sabai.upnp.intmin);
intmax=$(uci get sabai.upnp.intmax);
intrange= "$intmin"-"$intmax"
extmin=$(uci get sabai.upnp.extmin);
extmax=$(uci get sabai.upnp.extmax);
extrange="$extmin"-"$extmax"
#Show in my Network places is not yet supported in OpenWRT to my knowledge
#show=$(uci get sabai.upnp.show);

#Script Function 

_on(){
    uci set upnp.enable_upnp=1
    if [clean="on"]
      uci set upnp.clean_ruleset_interval=600
    fi
    if [secure="on"]
      uci set upnp.secure_mode=1
    fi
    uci set upnp.int_ports=$intrange
    uci set upnp.ext_ports=$extrange 
    uci commit
    /etc/init.d/firewall restart
}
                                        
_off(){
  uci set upnp.enable_upnp=0
  uci commit
  /etc/init.d/firewall restart
}

ls >/dev/null 2>/dev/null 

case $enable in
on)  _on ;;
off) _off ;;
esac
