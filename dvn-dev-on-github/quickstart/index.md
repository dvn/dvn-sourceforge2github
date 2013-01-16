---
layout: default
title: DVN on GitHub
---
Some day this will replace parts of the DVN Developer's Guide at http://guides.thedata.org

## Clone the repo

In NetBeans, click Team, then Git, then Clone.

### Remote Repository

- Repository URL: `github.com:IQSS/dvn.git`
- Username: `git`
- Private/Public Key
    - Private Key File: `/Users/[YOUR_USERNAME]/id_rsa`
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

NetBeans should detect 5 projects. Click Open Project. Select DVN-web and check Open Required and click Open.

Expect to see a dialog about reference problems. We need to configure libraries in NetBeans.

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
