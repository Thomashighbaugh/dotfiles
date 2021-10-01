# GNUPG

While I obviously store my personal private keys elsewhere, I have included my `gpg.conf` in this repository for symlinking in the installation function `GPG`.

## Configurations

Of primary importance, the greeting and the permission warning are both turned off by default, limiting the typical annoyance of `GNU` software by a factor of 10. Lock is also turned off, as a single unlock of the keyring is sufficient for me and my purposes.

Due to issues with the keyserver once common on arch due to the servers it was reaching out to, I have set a timeout of 10, `import-clean`, `no-self-sign-only` and set the keyserver to `hkp://keyserver.ubuntu.com`. The latter having solved the keyserver lagging issue entirely for me, which was highly irritating to say the least.

## Key Import Script

Additionally, a script is included that is only useful to me (or anyone hacking into my Dropbox...) that imports my keys into the system. It could serve as a template for you personally though (and is password protected at the key level for those who are getting nefarious ideas).
