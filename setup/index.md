---
layout: default
title: Setup for GitHub and ssh keys
---
## Ensure you have a GitHub account

Please make sure your GitHub account is listed under `GITHUB_USERNAME` at https://github.com/dvn/dvn-sourceforge2github/blob/master/authors.tsv

## Set up an ssh keypair

You *can* use git with passwords over HTTPS but it's much nicer to set up SSH keys.

https://github.com/settings/ssh is the place to manage the ssh keys GitHub knows about for you. That page also links to a nice howto: https://help.github.com/articles/generating-ssh-keys

From the terminal, `ssh-keygen` will create new ssh keys for you:

- private key: `~/.ssh/id_rsa` 
    - It is **very important to protect your private key**. If someone else acquires it, they can access private repositories on GitHub and make commits as you! Ideally, you'll stored your ssh keys on an encrypted volume and protect your private key with a password when prompted for one by `ssh-keygen`. See also "Why do passphrases matter" at https://help.github.com/articles/generating-ssh-keys
- public key: `~/.ssh/id_rsa.pub` 
