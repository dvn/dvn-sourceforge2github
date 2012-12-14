The Dataverse Network Project ( http://thedata.org ) is planning on [migrating from svn on SourceForge to git on GitHub](https://redmine.hmdc.harvard.edu/issues/1188).

This repo will capture the migration process.

We use https://dvn.svn.sourceforge.net/svnroot/dvn/dvn-app/trunk as path to the svn repo per http://guides.thedata.org/book/3-check-out-new-copy-dvn-source 

## Set up authors file

FIXME: make this into a file

FIXME: this `svn log` output is misleading and doesn't include all the authors: http://irclog.perlgeek.de/crimsonfu/2012-12-14#i_6244399

    murphy:tmp pdurbin$ svn log --quiet https://dvn.svn.sourceforge.net/svnroot/dvn/dvn-app/trunk | grep -E "r[0-9]+ \| .+ \|" | awk '{print $3}' | sort | uniq
    Error validating server certificate for 'https://dvn.svn.sourceforge.net:443':
     - The certificate is not issued by a trusted authority. Use the
       fingerprint to validate the certificate manually!
    Certificate information:
     - Hostname: *.svn.sourceforge.net
     - Valid: from Sat, 25 Feb 2012 23:58:41 GMT until Sun, 31 Mar 2013 19:51:44 GMT
     - Issuer: GeoTrust, Inc., US
     - Fingerprint: 0b:11:76:de:db:4c:74:72:cb:01:49:7d:13:70:c2:f1:13:7b:cb:bf
    (R)eject, accept (t)emporarily or accept (p)ermanently? t
    alexdamour
    bobtreacy
    ekraffmiller
    fiercetek
    helencaminal
    kcondon
    landreev
    mheppler
    noel90
    scolapasta
    skraffmiller
    xyang02
    murphy:tmp pdurbin$ 

## Install RVM and svn2git

See also https://rvm.io/rvm/install/

    murphy:~ pdurbin$ \curl -L https://get.rvm.io | bash -s stable --ruby
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100   185  100   185    0     0    313      0 --:--:-- --:--:-- --:--:--   488
    100 10242  100 10242    0     0   8137      0  0:00:01  0:00:01 --:--:-- 36841
    Please read and follow further instructions.
    Press ENTER to continue.
    Downloading RVM from wayneeseguin branch stable
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100   131  100   131    0     0    939      0 --:--:-- --:--:-- --:--:--  1056
    100 1243k  100 1243k    0     0   846k      0  0:00:01  0:00:01 --:--:-- 1786k

    Installing RVM to /Users/pdurbin/.rvm/
        Adding rvm PATH line to /Users/pdurbin/.bashrc /Users/pdurbin/.zshrc.
        RVM sourcing line found in /Users/pdurbin/.bashrc.

    # RVM:  Shell scripts enabling management of multiple ruby environments.
    # RTFM: https://rvm.io/
    # HELP: http://webchat.freenode.net/?channels=rvm (#rvm on irc.freenode.net)
    # Cheatsheet: http://cheat.errtheblog.com/s/rvm/
    # Screencast: http://screencasts.org/episodes/how-to-use-rvm

    # In case of any issues read output of 'rvm requirements' and/or 'rvm notes'

    Installation of RVM in /Users/pdurbin/.rvm/ is almost complete:

      * To start using RVM you need to run `source /Users/pdurbin/.rvm/scripts/rvm`
        in all your open shell windows, in rare cases you need to reopen all shell windows.

    # Philip Durbin,
    #
    #   Thank you for using RVM!
    #   I sincerely hope that RVM helps to make your life easier and
    #   more enjoyable!!!
    #
    # ~Wayne


    rvm 1.17.3 (stable) by Wayne E. Seguin <wayneeseguin@gmail.com>, Michal Papis <mpapis@gmail.com> [https://rvm.io/]

    https://rvm.io/binaries/osx/10.8/x86_64/ruby-1.9.3-p327.tar.bz2 - #configure
    ruby-1.9.3-p327 - #download
      % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                     Dload  Upload   Total   Spent    Left  Speed
    100 5693k  100 5693k    0     0  1350k      0  0:00:04  0:00:04 --:--:-- 1377k
    ruby-1.9.3-p327 - #extract
    ruby-1.9.3-p327 - #validate
    ruby-1.9.3-p327 - #setup
    Saving wrappers to '/Users/pdurbin/.rvm/bin'.
    ruby-1.9.3-p327 - #importing default gemsets (/Users/pdurbin/.rvm/gemsets/), this may take time ...
    Creating alias default for ruby-1.9.3-p327.
    Recording alias default for ruby-1.9.3-p327.
    Creating default links/files
    Saving wrappers to '/Users/pdurbin/.rvm/bin'.

      * To start using RVM you need to run `source /Users/pdurbin/.rvm/scripts/rvm`
        in all your open shell windows, in rare cases you need to reopen all shell windows.
    murphy:~ pdurbin$ 

## Install svn2git

See also https://github.com/nirvdrum/svn2git

    murphy:~ pdurbin$ gem install svn2git
    Fetching: svn2git-2.2.2.gem (100%)
    Successfully installed svn2git-2.2.2
    1 gem installed
    Installing ri documentation for svn2git-2.2.2...
    Installing RDoc documentation for svn2git-2.2.2...
    murphy:~ pdurbin$ 

## Run conversion script

    murphy:dvn-sourceforge2github pdurbin$ ./convert 
    Running `rsync -av dvn.svn.sourceforge.net::svn/dvn/* /Users/pdurbin/github/dvn/dvn-sf-rsync`
    rsync command completed successfully
    Time elapsed: 10.12 seconds (0.17 minutes)
    Running `svn2git file:///Users/pdurbin/github/dvn/dvn-sf-rsync --trunk dvn-app/trunk --branches dvn-app/branches`
    svn2git command completed successfully
    Time elapsed: 1102.55 seconds (18.38 minutes)
    murphy:dvn-sourceforge2github pdurbin$ 

FIXME: push to GitHub, etc.
