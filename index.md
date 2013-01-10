---
layout: default
title: DVN Developer's Guide - SourceForge (svn) to GitHub Migration
---
## Introduction

The Dataverse Network Project is migrating from SourceForge to GitHub (and svn to git) as described in https://redmine.hmdc.harvard.edu/issues/1188

This guide is intended to help DVN developers transition from using svn to git and GitHub, specifically.

## Ensure you have a GitHub account

Please make sure your GitHub account is listed under `GITHUB_USERNAME` at https://github.com/dvn/dvn-sourceforge2github/blob/master/authors.tsv

## Set up a ssh keypair

You *can* use git with passwords over HTTPS but it's much nicer to set up SSH keys.

https://github.com/settings/ssh is the place to manage the ssh keys GitHub knows about for you. That page also links to a nice howto: https://help.github.com/articles/generating-ssh-keys

From the terminal, `ssh-keygen` will create new ssh keys for you:

- private key: `~/.ssh/id_rsa` 
    - It is **very important to protect your private key**. If someone else acquires it, they can access private repositories on GitHub and make commits as you! Ideally, you'll stored your ssh keys on an encrypted volume and protect your private key with a password when prompted for one by `ssh-keygen`. See also "Why do passphrases matter" at https://help.github.com/articles/generating-ssh-keys
- public key: `~/.ssh/id_rsa.pub` 

## Demo with iqss-javaee-template

Before talking about DVN, we'll do a quick demo with a smaller and lighter example: iqss-javaee-template

### Clone iqss-javaee-template in NetBeans

In NetBeans, click Team, then Git, then Clone.

#### Remote Repository

- Repository URL: `github.com:IQSS/iqss-javaee-template.git`
- Username: `git`
- Private/Public Key
    - Private Key File: `/Users/[YOUR_USERNAME]/id_rsa`
- Passphrase: (the passphrase you chose while running `ssh-keygen`) 

Click Next.

#### Remote Branches

- Select Remote Branches: `master*`

Click Next.

#### Destination Directory

- Parent Directory: `/Users/[YOUR_USERNAME]/NetBeansProjects`
- Clone Name: `iqss-javaee-template`

Click Finish.

Click Open Project.
