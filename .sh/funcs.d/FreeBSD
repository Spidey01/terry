# vim: set ft=sh :
#


# quick commands to mute/unmute the sound system
#
mute() {
    OLD_VOLUME=`mixer -s`
    mixer vol 0:0 pcm 0:0

}
unmute() {
    # XXX FreeBSDs mixer command requires an EOF terminated argument
    # list. `echo $old` or `cat tmpfile` will work.
    mixer `echo $OLD_VOLUME` $*
}

free() {
    if in_path -b freecolor; then
        freecolor -o $*
    else
        echo "Please install freecolor." 2>/dev/null
    fi
}

my_cpu_status() {
    local ncpu i

    ncpu=$(sysctl -n hw.ncpu)

    # for each cpu
        # cur freq
        # max freq
        # min freq
        # available frequences
        # scaling driver
        # scaling governors
        # available governors
        # affected/related cpus
        # thermals

    i=0
    while [ "$i" -lt "$ncpu" ]; do
        echo "cpu${i}"

        printf "\tcur freq: $(sysctl -n dev.cpu.${i}.freq 2> /dev/null) Mhz\n"
        printf "\tavailable frequencies: $(sysctl -n dev.cpu.${i}.freq_levels 2> /dev/null)\n"
        printf "\tscaling driver: $(sysctl -n dev.cpufreq.${i}.%driver)\n"
        printf "\tC-state methods: $(sysctl -n dev.cpu.${i}.cx_method)\n"
        printf "\tC-state usages: "; sysctl -n dev.cpu.${i}.cx_usage
        printf "\tC-state supported: $(sysctl -n dev.cpu.${i}.cx_supported)\n"

        i=$(expr "$i" + 1)
    done

    # thermal zones (tz%d) are just listed in the order from ACPI. Can't tell
    # which are CPU and which are other things.
    sysctl hw.acpi.thermal | grep tz[0-9]*.temperature
}

