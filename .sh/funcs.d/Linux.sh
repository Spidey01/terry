# vim: set ft=sh :
#

my_cpu_status() {
    local cpu n freq temp

    for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
        n=$(basename $cpu)

        echo "${n}:"

        if [ ! -d ${cpu}/cpufreq ]; then
            printf "\tno cpufreq data.\n"
            continue
        fi

        # cpuinfo_cur_freq isn't publically readable; scaling_cur_freq should be.
        printf "\tcur freq: $(expr $(cat ${cpu}/cpufreq/scaling_cur_freq) / 1000) Mhz\n"
        printf "\tmax freq: $(expr $(cat ${cpu}/cpufreq/scaling_max_freq) / 1000) Mhz\n"
        printf "\tmin freq: $(expr $(cat ${cpu}/cpufreq/scaling_min_freq) / 1000) Mhz\n"
        printf "\tavailable frequencies: "
        for freq in $(cat ${cpu}/cpufreq/scaling_available_frequencies); do
            printf "$(expr $freq / 1000) Mhz; "
        done
        printf "\n"
        printf "\tscaling driver: $(cat ${cpu}/cpufreq/scaling_driver)\n"
        printf "\tscaling governors: $(cat ${cpu}/cpufreq/scaling_governor)\n"
        printf "\tavailable governors: $(cat ${cpu}/cpufreq/scaling_available_governors)\n"
        printf "\taffected cpus: $(cat ${cpu}/cpufreq/affected_cpus)\n"
        printf "\trelated cpus: $(cat ${cpu}/cpufreq/related_cpus)\n"
    done

    for temp in /sys/devices/virtual/thermal/thermal_zone[0-9]*/temp; do
        if [ -f "$temp" ]; then
            echo "$(basename $(dirname $temp)):"
            printf "\ttemp: $(expr $(cat "$temp") / 1000) C\n"
        fi
    done
}

get_power_state() {
    #
    # acpi can be used to detect power state on linux:
    #
    # [ terry@alice ]() acpi -a
    # Adapter 0: on-line
    # [ terry@alice ]() acpi -a
    # Adapter 0: off-line
    # [ terry@alice ]() acpi -b
    # Battery 0: Discharging, 100%, 05:30:04 remaining
    # [ terry@alice ]() acpi -b
    # Battery 0: Charging, 98%, 00:06:23 until charged
    # [ terry@alice ]() acpi -b
    # Battery 0: Full, 100%
    # [ terry@alice ]()
    #
    case `acpi -b | cut -d , -f 1 | cut -d : -f 2` in
        *Charging|*Full)
            echo 'adapter'
            ;;
        *Discharging)
            echo 'battery'
            ;;
        *)
            echo 'unknown'
            ;;
    esac
}
