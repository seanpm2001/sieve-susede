require ["fileinto", "mailbox", "variables", "include", "envelope"];
global [ "SUSEDE_ADDR", "SUSECOM_ADDR", "USERNAME" ];

# rule:[Spam]
if allof (  header :contains "X-Spam-Flag" "YES",

                        # Important  emails I don't want
                        # that fall into the SPAM folder
                        #_____________________________#
                        ###    W H I T E L I S T    ###
                        #▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔▔#

            # Always deliver distros and linux-distros messages
            not header :is "X-List" "vs.openwall.org",

            # osss usually gets very few SPAM emails. Most of the flagged ones are false positives.
            # Hence, whitelist all of them.
            not header :is "List-ID" "<oss-security.lists.openwall.com>",

            # Always deliver CISA notifications
            not address :is "From" [ "cert+donotreply@cert.org", "US-CERT@messages.cisa.gov" ],

            # Jenkis' security advisories are always flagged as SPAM due to the misconfigured DKIM
            # record of the domain of the usual sender (*@beckweb.net)
            # dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=beckweb.net (policy=quarantine);
            not allof ( header :contains "List-ID" "<oss-security.lists.openwall.com>",
                        header :contains "Subject" "Jenkins",
                        header :contains "Subject" "vulnerabilit"
            ),

            # Always allow SUSE BZ notifications
            not address :is "From" "bugzilla_noreply@suse.com",

            # Always deliver internal gitlab instance notifications
            not envelope :is "From" "gitlab@suse.de"

) {
    fileinto :create "INBOX/Spam";
    stop;
}
