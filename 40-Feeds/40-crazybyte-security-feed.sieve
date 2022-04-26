require [ "fileinto", "mailbox", "envelope", "subaddress", "variables", "include", "imap4flags" ];

###################################
##### CRAZYBYTE SECURITY FEED #####
###################################
# Notifications are generated by a rss2email daemon. Source code and configuration
# can be found here: https://github.com/StayPirate/rss2email
#
# Feed
# ├── Weekly update
# │   ├── Ubuntu sec podcast
# │   ├── SSD
# │   └── AT&T
# ├── Blog
# │   ├── TOR
# │   ├── Darknet Diaries
# │   ├── Mozilla
# │   ├── Github
# │   ├── Microsoft
# │   ├── Chromium
# │   ├── Chrome
# │   ├── Good Reads
# │   └── Guerredirete
# ├── Ezine
# │   ├── AppSec
# │   └── POCorGTFO
# ├── SA
# │   ├── Github
# │   ├── PowerDNS
# │   ├── RustSec
# │   ├── Debian
# │   └── Drupal
# └── Release
#     ├── Podman
#     ├── ClamAV
#     ├── Chrome
#     └── SUSE
#         ├── Secbox
#         └── Userscripts

if header :is "X-RSS-Instance" "crazybyte-security-feed" {

    # rule:[convert X-RSS-Tags to IMAP-flags]
    # This rule takes the whole string in the header X-RSS-Tags and use it to set IMAP-flags.
    # The string is expected to be either a single word or multiple words separated by a single space.
    if exists "X-RSS-Tags" {
        if header :matches "X-RSS-Tags" "*" {
            addflag "${1}";
        }
    }

#   ██╗    ██╗███████╗███████╗██╗  ██╗██╗  ██╗   ██╗    ██╗   ██╗██████╗ ██████╗  █████╗ ████████╗███████╗
#   ██║    ██║██╔════╝██╔════╝██║ ██╔╝██║  ╚██╗ ██╔╝    ██║   ██║██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝██╔════╝
#   ██║ █╗ ██║█████╗  █████╗  █████╔╝ ██║   ╚████╔╝     ██║   ██║██████╔╝██║  ██║███████║   ██║   █████╗  
#   ██║███╗██║██╔══╝  ██╔══╝  ██╔═██╗ ██║    ╚██╔╝      ██║   ██║██╔═══╝ ██║  ██║██╔══██║   ██║   ██╔══╝  
#   ╚███╔███╔╝███████╗███████╗██║  ██╗███████╗██║       ╚██████╔╝██║     ██████╔╝██║  ██║   ██║   ███████╗
#    ╚══╝╚══╝ ╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚═╝        ╚═════╝ ╚═╝     ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚══════╝

    # rule:[Ubuntu security podcast]
    # https://ubuntusecuritypodcast.org
    if header :is "X-RSS-Feed" "https://ubuntusecuritypodcast.org/" {
        fileinto :create "INBOX/Feed/Weekly update/Ubuntu sec podcast";
        stop;
    }

    # rule:[SSD Secure Disclosure]
    # https://www.youtube.com/channel/UC9ZnYbYqOe6Y3eRdw0TMz9Q
    if header :is "X-RSS-Feed" "https://www.youtube.com/channel/UC9ZnYbYqOe6Y3eRdw0TMz9Q" {
        fileinto :create "INBOX/Feed/Weekly update/SSD";
        stop;
    }

    # rule:[AT&T Youtube tech channel]
    # https://www.youtube.com/channel/UCnpDurxReTSpFs5-AhDo8Kg
    if header :is "X-RSS-Feed" "https://www.youtube.com/channel/UCnpDurxReTSpFs5-AhDo8Kg" {
        fileinto :create "INBOX/Feed/Weekly update/AT&T";
        stop;
    }

    # rule:[Dayzerosec Podcast]
    # https://dayzerosec.com/podcast/
    if header :is "X-RSS-Feed" "https://dayzerosec.com/" {
        fileinto :create "INBOX/Feed/Weekly update/Dayzerosec";
        stop;
    }

#   ██████╗ ██╗      ██████╗  ██████╗ 
#   ██╔══██╗██║     ██╔═══██╗██╔════╝ 
#   ██████╔╝██║     ██║   ██║██║  ███╗
#   ██╔══██╗██║     ██║   ██║██║   ██║
#   ██████╔╝███████╗╚██████╔╝╚██████╔╝
#   ╚═════╝ ╚══════╝ ╚═════╝  ╚═════╝ 

    # rule:[Chromium Blog (security)]
    # http://blog.chromium.org
    if allof ( header :contains "X-RSS-Feed" "blog.chromium.org",
               header :contains "Keywords" "security" ) {
        fileinto :create "INBOX/Feed/Blog/Chromium";
        stop;
    }

    # rule:[Chrome Blog (security)]
    # http://security.googleblog.com/
    if header :contains "X-RSS-Feed" "http://security.googleblog.com/" {
        fileinto :create "INBOX/Feed/Blog/Chrome";
        stop;
    }

    # rule:[Microsoft Security Blog]
    # https://www.microsoft.com/security/blog
    if header :is "X-RSS-Feed" "https://www.microsoft.com/security/blog" {
        fileinto :create "INBOX/Feed/Blog/Microsoft";
        stop;
    }

    # rule:[GitHub Security Blog]
    # https://github.blog/category/security/feed/
    if header :is "X-RSS-Feed" "https://github.blog" {
        fileinto :create "INBOX/Feed/Blog/Github";
        stop;
    }

    # rule:[Mozilla Security Blog]
    # https://blog.mozilla.org/security
    if header :is "X-RSS-Feed" "https://blog.mozilla.org/security" {
        fileinto :create "INBOX/Feed/Blog/Mozilla";
        stop;
    }

    # rule:[Darknet Diaries Podcast]
    # https://darknetdiaries.com/
    if header :is "X-RSS-Feed" "https://darknetdiaries.com/" {
        fileinto :create "INBOX/Feed/Blog/Darknet Diaries";
        stop;
    }

    # rule:[TOR blog]
    # https://blog.torproject.org/
    if header :is "X-RSS-Feed" "https://blog.torproject.org/" {
        fileinto :create "INBOX/Feed/Blog/TOR";
        stop;
    }

    # rule:[Guerre di rete]
    # https://guerredirete.substack.com
    if header :is "X-RSS-Feed" "https://guerredirete.substack.com" {
        fileinto :create "INBOX/Feed/Blog/Guerredirete";
        stop;
    }

    # rule:[Justin Steven SA]
    # https://github.com/justinsteven/advisories
    if header :is "X-RSS-Feed" "https://github.com/justinsteven/advisories/commits/main" {
        fileinto :create "INBOX/Feed/Blog/Good Reads";
        stop;
    }

    # rule:[Cryptography Dispatches]
    # Cryptography Dispatches by Filippo Valsorda (AKA FiloSottile)
    # https://buttondown.email/cryptography-dispatches
    if header :is "X-RSS-Feed" "https://buttondown.email/cryptography-dispatches" {
        fileinto :create "INBOX/Feed/Blog/Good Reads";
        stop;
    }

#   ███████╗███████╗██╗███╗   ██╗███████╗
#   ██╔════╝╚══███╔╝██║████╗  ██║██╔════╝
#   █████╗    ███╔╝ ██║██╔██╗ ██║█████╗  
#   ██╔══╝   ███╔╝  ██║██║╚██╗██║██╔══╝  
#   ███████╗███████╗██║██║ ╚████║███████╗
#   ╚══════╝╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝

    # rule:[AppSec]
    # https://github.com/Simpsonpt/AppSecEzine
    if header :is "X-RSS-Feed" "https://github.com/Simpsonpt/AppSecEzine/commits/master" {
        fileinto :create "INBOX/Feed/Ezine/AppSec";
        stop;
    }

    # rule:[POCorGTFO]
    # POC||GTFO Ezine feed - from the Evan Sultanik website (one of the main mirrors)
    # https://www.sultanik.com/pocorgtfo/
    if allof ( header :is       "X-RSS-Feed" "https://www.sultanik.com/",
               header :contains "X-RSS-Link" "https://www.sultanik.com/pocorgtfo" ) {
        fileinto :create "INBOX/Feed/Ezine/POCorGTFO";
        stop;
    }

#   ███████╗███████╗ ██████╗     █████╗ ██████╗ ██╗   ██╗██╗███████╗ ██████╗ ██████╗ ██╗   ██╗
#   ██╔════╝██╔════╝██╔════╝    ██╔══██╗██╔══██╗██║   ██║██║██╔════╝██╔═══██╗██╔══██╗╚██╗ ██╔╝
#   ███████╗█████╗  ██║         ███████║██║  ██║██║   ██║██║███████╗██║   ██║██████╔╝ ╚████╔╝ 
#   ╚════██║██╔══╝  ██║         ██╔══██║██║  ██║╚██╗ ██╔╝██║╚════██║██║   ██║██╔══██╗  ╚██╔╝  
#   ███████║███████╗╚██████╗    ██║  ██║██████╔╝ ╚████╔╝ ██║███████║╚██████╔╝██║  ██║   ██║   
#   ╚══════╝╚══════╝ ╚═════╝    ╚═╝  ╚═╝╚═════╝   ╚═══╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝  ╚═╝   ╚═╝   

    # rule:[GitHub Security Advisory]
    # https://securitylab.github.com/
    if header :is "X-RSS-Feed" "https://securitylab.github.com/" {
        fileinto :create "INBOX/Feed/SA/Github";
        stop;
    }

    # rule:[Drupal]
    # https://www.drupal.org/security
    if header :is "X-RSS-Feed" "https://www.drupal.org/security" {
        fileinto :create "INBOX/Feed/SA/Drupal";
        stop;
    }

    # rule:[PowerDNS]
    # https://powerdns.com
    if allof ( header :is "X-RSS-Feed" "https://blog.powerdns.com",
               header :contains "Subject" "Security Advisory" ) {
        fileinto :create "INBOX/Feed/SA/PowerDNS";
        stop;
    }

    # rule:[RustSec]
    # https://rustsec.org - The Rust Security Advisory Database
    if header :is "X-RSS-Feed" "https://rustsec.org/" {
        fileinto :create "INBOX/Feed/SA/RustSec";
        stop;
    }

    # Debian Security Advisories (DSA) are gotten by the debian-security-announce ML, since
    # it provides much more detailed information compared to the DSA RSS-feed.
    # DSA ML:       https://lists.debian.org/debian-security-announce/
    # DSA RSS-feed: https://www.debian.org/security/dsa

#   ██████╗ ███████╗██╗     ███████╗ █████╗ ███████╗███████╗
#   ██╔══██╗██╔════╝██║     ██╔════╝██╔══██╗██╔════╝██╔════╝
#   ██████╔╝█████╗  ██║     █████╗  ███████║███████╗█████╗  
#   ██╔══██╗██╔══╝  ██║     ██╔══╝  ██╔══██║╚════██║██╔══╝  
#   ██║  ██║███████╗███████╗███████╗██║  ██║███████║███████╗
#   ╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝

    # rule:[Chrome]
    # https://chromereleases.googleblog.com
    if allof ( header :contains "X-RSS-Feed" "chromereleases.googleblog.com",
               header :contains "Keywords" "Desktop Update",
               header :contains "Keywords" "Stable updates" ) {
        fileinto :create "INBOX/Feed/Release/Chrome";
        stop;
    }

    # rule:[ClamAV]
    # https://www.clamav.net/
    if header :is "X-RSS-Feed" "http://blog.clamav.net/" {
        fileinto :create "INBOX/Feed/Release/ClamAV";
        stop;
    }

    # rule:[Podman]
    # https://www.drupal.org/security
    if header :is "X-RSS-Feed" "https://github.com/containers/podman/releases" {
        fileinto :create "INBOX/Feed/Release/Podman";
        stop;
    }

    # rule:[SUSE userscripts]
    # https://gitlab.suse.de/gsonnu/userscripts
    if header :is "X-RSS-Feed" "https://gitlab.suse.de/gsonnu/userscripts" {
        fileinto :create "INBOX/Feed/Release/SUSE/Userscripts";
        stop;
    }

    # rule:[SUSE secbox]
    # https://github.com/StayPirate/secbox
    if header :is "X-RSS-Feed" "https://github.com/StayPirate/secbox/releases" {
        fileinto :create "INBOX/Feed/Release/SUSE/Secbox";
        stop;
    }

    #_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#
    #                                                       #
    #   If no rule matched the notification is discarded.   #
    #                                                       #
    #_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#

    #discard;
    fileinto :create "INBOX/Trash";

}