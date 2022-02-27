#! /bin/vbash
source /opt/vyatta/etc/functions/script-template
configure

for number in {43..99}
do
    export NUMBER="$number"
    export RULE_N="1$NUMBER"
    export DEST_PORT_COMPLETO="220${NUMBER}"
    export IP_ADDR="10.10.10.$NUMBER"
    set nat destination rule "$RULE_N" destination port "$DEST_PORT_COMPLETO"

    set nat destination rule "$RULE_N" inbound-interface 'eth1'

    set nat destination rule "$RULE_N" protocol 'tcp'

    set nat destination rule "$RULE_N" translation address "$IP_ADDR"

    set nat destination rule "$RULE_N" translation port '22'
    commit
done


#! /bin/vbash
source /opt/vyatta/etc/functions/script-template
configure

for number in {0..254}
do
    export NUMBER="$number"
    export RULE_N="1$NUMBER"
    export DEST_PORT_COMPLETO="0${NUMBER}22"
    export IP_ADDR="10.10.10.$NUMBER"
    delete nat destination rule "$RULE_N" 

    commit
done


#! /bin/vbash
source /opt/vyatta/etc/functions/script-template
configure
    
    export RULE_N="002"
    export DEST_PORT_COMPLETO="3389"
    export IP_ADDR="10.10.10.10"
    set nat destination rule "$RULE_N" destination port "$DEST_PORT_COMPLETO"

    set nat destination rule "$RULE_N" inbound-interface 'eth1'

    set nat destination rule "$RULE_N" protocol 'tcp'

    set nat destination rule "$RULE_N" translation address "$IP_ADDR"

    set nat destination rule "$RULE_N" translation port "$DEST_PORT_COMPLETO"
    commit