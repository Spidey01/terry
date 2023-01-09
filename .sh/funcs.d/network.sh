#
# Network related functions.
#

test_dns() {
    #
    # quick test of each name server on unix box.
    #
    for _IP in `cat /etc/resolv.conf | awk '/^nameserver/ { print $2 }'`
    do
        ping -c ${1:-3} "$_IP" | tail -n 1
    done
    unset _IP
}

get_ipaddr() {
    #
    # Prints the current machines IP address.
    #
    # params: 
    #   $1  = interface to query
    #   $2  = prefix, default is 'inet'
    #
    #
    
    type ifconfig >/dev/null 2>/dev/null && \
         ifconfig | grep $1 >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
        ifconfig "$1" | grep "${2:-inet} " | awk '{ print $2 }' | head -n 1
    fi

}
