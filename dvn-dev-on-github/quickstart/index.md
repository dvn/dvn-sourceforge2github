---
layout: default
title: DVN on GitHub
---
## Introduction

The goal of this "quickstart" is to switch your build environment from SourceForge to GitHub to produce a war file. To actually deploy the war to Glassfish on your workstation, you need to have PostgreSQL and the rest of your application environment set up per the DVN Developer's Guide at http://guides.thedata.org

In time, we'll incorporate all of this into the guide itself.

## New branching model: develop vs. master

<a href="http://nvie.com/posts/a-successful-git-branching-model/"><img src="master-develop.png" align="right" ></a>

Please note that with the move to git, we are adopting the branching model described at http://nvie.com/posts/a-successful-git-branching-model/

In this branching model there are two persistent branches:

- develop: where all new commits go
- master: where code gets merged and tagged as a release

That is to say, **please make your commits on the develop branch, not the master branch**. 

## Ensure you have a GitHub account

Please make sure your GitHub account is listed under `GITHUB_USERNAME` at https://github.com/dvn/dvn-sourceforge2github/blob/master/authors.tsv

## Set up an ssh keypair (if you haven't already)

You *can* use git with passwords over HTTPS but it's much nicer to set up SSH keys.

https://github.com/settings/ssh is the place to manage the ssh keys GitHub knows about for you. That page also links to a nice howto: https://help.github.com/articles/generating-ssh-keys

From the terminal, `ssh-keygen` will create new ssh keys for you:

- private key: `~/.ssh/id_rsa` 
    - It is **very important to protect your private key**. If someone else acquires it, they can access private repositories on GitHub and make commits as you! Ideally, you'll store your ssh keys on an encrypted volume and protect your private key with a password when prompted for one by `ssh-keygen`. See also "Why do passphrases matter" at https://help.github.com/articles/generating-ssh-keys
- public key: `~/.ssh/id_rsa.pub`

## Clone the repo

In NetBeans 7.1.1 or higher, click Team, then Git, then Clone.

### Remote Repository

- Repository URL: `github.com:IQSS/dvn.git`
- Username: `git`
- Private/Public Key
    - Private Key File: `/Users/[YOUR_USERNAME]/.ssh/id_rsa`
- Passphrase: (the passphrase you chose while running `ssh-keygen`) 

Click Next.

### Remote Branches

Under Select Remote Branches check both of these:

- `develop*`
- `master*`

Click Next.

### Destination Directory

- Parent Directory: `/Users/[YOUR_USERNAME]/NetBeansProjects`
- Clone Name: `dvn`
- Checkout Branch: `develop*`

Click Finish.

At this point, you'll need to quit NetBeans so we can retrieve nbproject files from git history. Open a terminal and run these commands:

    cd ~/NetBeansProjects/dvn
    git checkout f1dc53c src/DVN-web/nbproject
    git checkout f1dc53c src/DVN-ingest/nbproject

Then, run `git status` and unstage any files that git shows as new:

    git reset HEAD path/to/files-git-status-shows-as-new

At this point, your nbproject files should be in place.

Launch NetBeans and it should detect 5 projects. Click Open Project. Select DVN-web and check Open Required (so that DVN-ingest is also opened) and click Open.

Expect to see a dialog about reference problems. We need to configure libraries in NetBeans.

Please note that you should only have two projects open (DVN-web and DVN-ingest). If you click File -> Open Project you may see other projects such as DVN-EAR, DVN-EJB, and DVN-lockss but you should not open them or you will likely see build errors.

## Configure NetBeans libraries

Create the following 5 custom libraries using Tools -> Ant Libraries -> New Library:

- dvn-lib-COMMON
- dvn-lib-EJB
- dvn-lib-WEB
- dvn-lib-NETWORKDATA
- dvn-lib-NETWORKDATA-EXTRA

For each of these, simply select all the jar files from the directories

- lib/dvn-lib-COMMON
- lib/dvn-lib-EJB
- lib/dvn-lib-WEB
- lib/dvn-lib-NetworkData
- lib/dvn-lib-NetworkData-EXTRA

respectively.

Finally, add the following 5 JAR files in the Glassfish directory as compile-time libraries to your project:

In NetBeans, open the "Properties" menu of the DVN-web project; then go to Libraries. Add the following 5 jar files, on at a time:
 
- auto-depends.jar
- common-util.jar
- config-api.jar
- grizzly-config.jar
- internal-api.jar

by clicking on "Add JAR/Folder", then selecting each jar in the .../glassfish/modules directory of your 3.1.2 installation. (For example, /Applications/NetBeans/glassfish-3.1.2/glassfish/modules). Leave the "Package" box unchecked for each of these. 

## Files changed by NetBeans during a clone

After cloning the project from GitHub, NetBeans 7.2.1 seems to change a number of files even before you do anything...

    murphy:dvn pdurbin$ git status
    # On branch develop
    # Changes not staged for commit:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #       modified:   src/DVN-ingest/nbproject/build-impl.xml
    #       modified:   src/DVN-ingest/nbproject/genfiles.properties
    #       modified:   src/DVN-web/nbproject/genfiles.properties
    #       modified:   src/DVN-web/nbproject/jaxws-build.xml
    #       modified:   src/DVN-web/nbproject/project.properties
    #
    no changes added to commit (use "git add" and/or "git commit -a")
    murphy:dvn pdurbin$ 

For now, we don't want developers to push these changes up to GitHub. To have your local git clone of the repo not report changes to these files, use the following command:

    murphy:dvn pdurbin$ git update-index --assume-unchanged src/DVN-ingest/nbproject/build-impl.xml src/DVN-ingest/nbproject/genfiles.properties src/DVN-web/nbproject/genfiles.properties src/DVN-web/nbproject/jaxws-build.xml src/DVN-web/nbproject/project.properties
    murphy:dvn pdurbin$ 

At this point, `git status` (and Netbeans) reports no changes, which is what we expect from a freshly cloned git repo:

    murphy:dvn pdurbin$ git status
    # On branch develop
    nothing to commit (working directory clean)
    murphy:dvn pdurbin$ 

(In the future we may remove some of these files from tracking with `git rm --cached` after we've run `git update-index --no-assume-unchanged` on some files. For more discussion of nbproject files and git see also http://irclog.iq.harvard.edu/dvn/2013-01-15#i_363 and https://redmine.hmdc.harvard.edu/issues/1188#note-13 )

## Pushing your commits to GitHub

By following the instructions above, you should be in the "develop" branch, which is where we want to make commits as we work toward the next release.

You can verify which branch you are on by clicking Team then "Repository Browser".

You should see `dvn [develop]` at the root of the tree and **develop** in bold under Branches -> Local

After making your commit, push it to GitHub by clicking Team -> Remote -> Push, then Next (to use your configured remote repository), then checking **develop** and Finish.

Your commit should now appear on GitHub in the develop branch: https://github.com/IQSS/dvn/commits/develop

Your commit should **not** appear in the master branch on GitHub: https://github.com/IQSS/dvn/commits/master  . Not yet anyway. Remember, we only merge commits into master when we are ready to release.

## Switching to the master branch to merge commits from the develop branch

We should really only need to switch from the develop branch to the master branch as we prepare for a release.

First, we check out the master branch by clicking Team -> Git -> Branch -> Switch to Branch.

Change Branch to "origin/master" and check the box for "Checkout as New Branch" and fill in "master" as the "Branch Name" to match the name of the branch we're switching to. Then click "Switch".

Now, in the Git Repository Browser (from Team -> Repository Browser) the root of the tree should say `dvn [master]` and you should see two branches under Branches -> Local. **master** should be in bold and develop should not.

FIXME: explain how to merge commits into master for a final release (and how to tag the release)

## If you commit and push to the `master` branch by mistake...

If no one has fetched the bad commit, you can try to remove the commit from your local git repo and GitHub by (carefully) following http://christoph.ruegg.name/blog/2010/5/5/git-howto-revert-a-commit-already-pushed-to-a-remote-reposit.html

## Previewing changes before a pull

If the build fails overnight you may want to hold off on doing a pull until the problem is resolved. To preview what has changed since your last pull, you can do a `git fetch` (the first part of a pull) then `git log HEAD..origin/develop` to see the commit messages. `git log -p` or `git diff` will allow you to see the contents of the changes:

    git checkout develop
    git fetch
    git log HEAD..origin/develop
    git log -p HEAD..origin/develop
    git diff HEAD..origin/develop

After the build is working again, you can simply do a pull as normal.

## Feature branches

> "The essence of a feature branch is that it exists as long as the feature is in development, but will eventually be merged back into develop (to definitely add the new feature to the upcoming release) or discarded (in case of a disappointing experiment)." -- http://nvie.com/posts/a-successful-git-branching-model/ 

### Example feature branch: 2656-lucene

First, we create the branch and check it out:

    murphy:dvn pdurbin$ git branch
      2656-solr
    * develop
    murphy:dvn pdurbin$ git branch 2656-lucene
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git branch
      2656-lucene
      2656-solr
    * develop
    murphy:dvn pdurbin$ git checkout 2656-lucene
    Switched to branch '2656-lucene'
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git status
    # On branch 2656-lucene
    nothing to commit (working directory clean)
    murphy:dvn pdurbin$ 

Then, we make a change and a commit, and push it to https://github.com/iqss/dvn/tree/2656-lucene (creating a new remote branch):

    murphy:dvn pdurbin$ vim src/DVN-EJB/src/java/edu/harvard/iq/dvn/core/index/Indexer.java
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git commit -m 'start lucene faceting branch' src/DVN-EJB/src/java/edu/harvard/iq/dvn/core/index/Indexer.java
    [2656-lucene 3b82f88] start lucene faceting branch
     1 file changed, 73 insertions(+), 2 deletions(-)
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git push origin 2656-lucene
    Counting objects: 25, done.
    Delta compression using up to 8 threads.
    Compressing objects: 100% (10/10), done.
    Writing objects: 100% (13/13), 2.23 KiB, done.
    Total 13 (delta 6), reused 0 (delta 0)
    To git@github.com:IQSS/dvn.git
     * [new branch]      2656-lucene -> 2656-lucene
    murphy:dvn pdurbin$ 

As we work on the feature branch, we merge the latest changes from "develop". We want to resolve conflicts in the feature branch itself so that the feature branch will merge cleanly into "develop" when we're ready. In the example below, we use `git mergetool` and `opendiff` to resolve conflicts and save the merge. Then we push the newly-merged 2656-lucene feature branch to GitHub.

    murphy:dvn pdurbin$ git branch
    * 2656-lucene
      2656-solr
      develop
    murphy:dvn pdurbin$ git checkout develop
    murphy:dvn pdurbin$ git branch
      2656-lucene
      2656-solr
    * develop
    murphy:dvn pdurbin$ git pull
    remote: Counting objects: 206, done.
    remote: Compressing objects: 100% (43/43), done.
    remote: Total 120 (delta 70), reused 96 (delta 46)
    Receiving objects: 100% (120/120), 17.65 KiB, done.
    Resolving deltas: 100% (70/70), completed with 40 local objects.
    From github.com:IQSS/dvn
       8fd223d..9967413  develop    -> origin/develop
    Updating 8fd223d..9967413
    Fast-forward
     .../admin/EditNetworkPrivilegesServiceBean.java  |    5 +-
    (snip)
     src/DVN-web/web/study/StudyFilesFragment.xhtml   |    2 +-
     12 files changed, 203 insertions(+), 118 deletions(-)
    murphy:dvn pdurbin$ murphy:dvn pdurbin$ git pull
    remote: Counting objects: 206, done.
    remote: Compressing objects: 100% (43/43), done.
    remote: Total 120 (delta 70), reused 96 (delta 46)
    Receiving objects: 100% (120/120), 17.65 KiB, done.
    Resolving deltas: 100% (70/70), completed with 40 local objects.
    From github.com:IQSS/dvn
       8fd223d..9967413  develop    -> origin/develop
    Updating 8fd223d..9967413
    Fast-forward
     .../admin/EditNetworkPrivilegesServiceBean.java  |    5 +-
    (snip)
     .../harvard/iq/dvn/core/web/study/StudyUI.java   |    2 +-
     src/DVN-web/web/HomePage.xhtml                   |    5 +-
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git checkout 2656-lucene
    Switched to branch '2656-lucene'
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git merge develop
    Auto-merging src/DVN-web/web/BasicSearchFragment.xhtml
    CONFLICT (content): Merge conflict in src/DVN-web/web/BasicSearchFragment.xhtml
    Auto-merging src/DVN-web/src/edu/harvard/iq/dvn/core/web/BasicSearchFragment.java
    Auto-merging src/DVN-EJB/src/java/edu/harvard/iq/dvn/core/index/Indexer.java
    Automatic merge failed; fix conflicts and then commit the result.
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git status
    # On branch 2656-lucene
    # Changes to be committed:
    #
    #       modified:   src/DVN-EJB/src/java/edu/harvard/iq/dvn/core/admin/EditNetworkPrivilegesServiceBean.java
    (snip)
    #       new file:   src/DVN-web/web/admin/ChooseDataverseForCreateStudy.xhtml
    #       modified:   src/DVN-web/web/study/StudyFilesFragment.xhtml
    #
    # Unmerged paths:
    #   (use "git add/rm <file>..." as appropriate to mark resolution)
    #
    #       both modified:      src/DVN-web/web/BasicSearchFragment.xhtml
    #
    murphy:dvn pdurbin$ git mergetool
    merge tool candidates: opendiff kdiff3 tkdiff xxdiff meld tortoisemerge gvimdiff diffuse ecmerge p4merge araxis bc3 emerge vimdiff
    Merging:
    src/DVN-web/web/BasicSearchFragment.xhtml

    Normal merge conflict for 'src/DVN-web/web/BasicSearchFragment.xhtml':
      {local}: modified file
      {remote}: modified file
    Hit return to start merge resolution tool (opendiff):
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git add .
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git commit -m "Merge branch 'develop' into 2656-lucene"
    [2656-lucene 519cd8c] Merge branch 'develop' into 2656-lucene
    murphy:dvn pdurbin$ 
    murphy:dvn pdurbin$ git push origin 2656-lucene
    (snip)
    murphy:dvn pdurbin$ 
