# Usage: sudo awk -f /usr/share/rpi-analyse-boot/psi_html.awk /proc/timer_list /proc/pressure/*
# Requires /proc/timer_list for the 'now' timestamp and /proc/pressure/* files for PSI data

BEGIN {
    print "<table border='1'>"
    print "<tr><th><strong>Resource</strong></th><th><strong>Partial Stall %</strong></th><th><strong>All Stalled %</strong></th></tr>"
}

# Capture the 'now' timestamp from /proc/timer_list
/^now/ {
    now_microseconds = $3 / 1000
}

# Process PSI lines from /proc/pressure/* files
/^(some|full)/ {
    # Extract resource name from filename
    split(FILENAME, parts, "/")
    resource = parts[4]  # cpu, io, memory

    stall_type = $1      # some or full

    # Extract total value from "total=XXXXXX"
    split($5, total_parts, "=")
    total_microseconds = total_parts[2]

    # Calculate percentage
    if (now_microseconds > 0) {
        percentage = (total_microseconds / now_microseconds) * 100
    } else {
        percentage = 0
    }

    # Store percentages by resource and stall type
    if (stall_type == "some") {
        some_pct[resource] = percentage
    } else if (stall_type == "full") {
        full_pct[resource] = percentage
    }

    # Keep track of resources we've seen
    resources[resource] = 1
}

END {
    # Output rows for each resource
    for (resource in resources) {
        printf "<tr><td><strong>%s</strong></td><td>%.3f%%</td><td>%.3f%%</td></tr>\n", \
               resource, \
               some_pct[resource], \
               full_pct[resource]
    }
    print "</table>"
}
