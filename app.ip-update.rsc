# Info: RouterOS.
:global wanInterface "PPTP.NAME"

# Debug.
:local cfDebug "true"

# Info: User.
:local cfEmail "user@cloudflare.com"
:local cfToken "0000000000000000000000000000000000000"

# Info: Domain.
:local cfDomain "example.com"
:local cfZoneID "1111111111111111111111111111111111111"
:local cfDNSID "2222222222222222222222222222222222222"
:local cfRecordType "A"

# DO NOT EDIT BELOW

# Internal variables.
:local resolvedIP ""
:global wanIP ""

# Resolve and set IP-variables.
:local currentIP [/ip address get [/ip address find interface=$wanInterface ] address];
:set wanIP [:pick $currentIP 0 [:find $currentIP "/"]];
:set resolvedIP [:resolve $cfDomain];

# Build CF API Url (v4).
:local cfURL "https://api.cloudflare.com/client/v4/zones/"
:set cfURL ($cfURL . "$cfZoneID/dns_records/$cfDNSID");

# Write debug info to log.
:if ($cfDebug = "true") do={
  :log info ("CF: hostname = $cfDomain")
  :log info ("CF: resolvedIP = $resolvedIP")
  :log info ("CF: currentIP = $currentIP")
  :log info ("CF: wanIP = $wanIP")
  :log info ("CF: cfURL = $cfURL&content=$wanIP")
};

# Compare and update CF if necessary.
:if ($resolvedIP != $wanIP) do={
  :log info ("CF: Updating CF, setting $cfDomain = $wanIP")
  /tool fetch http-method=put mode=https url="$cfURL" http-header-field="X-Auth-Email:$cfEmail,X-Auth-Key:$cfToken,content-type:application/json" output=none http-data="{\"type\":\"$cfRecordType\",\"name\":\"$cfDomain\",\"content\":\"$wanIP\"}"
  /ip dns cache flush
} else={
  :log info "CF: No Update Needed!"
}
