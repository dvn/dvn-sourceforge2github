The Dataverse Network Project ( http://thedata.org ) is planning on [migrating from svn on SourceForge to git on GitHub](https://redmine.hmdc.harvard.edu/issues/1188).

This repo will capture the migration process.

When we're done, we'll update http://guides.thedata.org/book/3-check-out-new-copy-dvn-source 

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

## Run conversion script and push repo to GitHub

Note that we clone this repo to a new directory and remove all of .git because a new .git directory will be created. The conversion files remain (seen by `git status`) but we simply won't commit them as we don't want them to be part of the source tree.

    murphy:dvn pdurbin$ git clone https://github.com/dvn/dvn-sourceforge2github.git dvn-svn-import-test4
    Cloning into 'dvn-svn-import-test4'...
    remote: Counting objects: 43, done.
    remote: Compressing objects: 100% (35/35), done.
    remote: Total 43 (delta 20), reused 30 (delta 7)
    Unpacking objects: 100% (43/43), done.
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ cd dvn-svn-import-test4
    murphy:dvn-svn-import-test4 pdurbin$ rm -rf .git
    murphy:dvn-svn-import-test4 pdurbin$ ./author-file-setup 
    murphy:dvn-svn-import-test4 pdurbin$ ./convert 
    Running `rsync -av dvn.svn.sourceforge.net::svn/dvn/* /Users/pdurbin/github/dvn/dvn-sf-rsync`
    rsync command completed successfully
    Time elapsed: 48.10 seconds (0.80 minutes)
    Running `svn2git file:///Users/pdurbin/github/dvn/dvn-sf-rsync --authors authors.txt --rootistrunk`
    svn2git command completed successfully
    Time elapsed: 1159.98 seconds (19.33 minutes)
    murphy:dvn-svn-import-test4 pdurbin$ 
    murphy:dvn-svn-import-test4 pdurbin$ git status
    # On branch master
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #       author-file-setup
    #       authors.tsv
    #       authors.txt
    #       convert
    #       readme.md
    nothing added to commit but untracked files present (use "git add" to track)
    murphy:dvn-svn-import-test4 pdurbin$ 

At this point we create a new repo on GitHub. The test import repos are going under https://github.com/dvn but the final repo will go under https://github.com/IQSS

Finally, we push the local repo to GitHub:

    murphy:dvn-svn-import-test4 pdurbin$ git remote add origin git@github.com:dvn/dvn-svn-import-test4.git
    murphy:dvn-svn-import-test4 pdurbin$ git push -u origin master
    Counting objects: 103398, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (28494/28494), done.
    Writing objects: 100% (103398/103398), 244.81 MiB | 780 KiB/s, done.
    Total 103398 (delta 56068), reused 103398 (delta 56068)
    To git@github.com:dvn/dvn-svn-import-test4.git
     * [new branch]      master -> master
    Branch master set up to track remote branch master from origin.
    murphy:dvn-svn-import-test4 pdurbin$ 
