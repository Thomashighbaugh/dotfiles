#!/bin/env bash

##############################################################################
## CUPS Printer Drivers ######################################################
##############################################################################

yay -S --noconfirm --sudoloop --batchinstall cups cups-filters cups-pdf cups-pk-helper foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds cups cups-filters cups-pdf cndrvcups-lb-bin cnijfilter2-bin cups-pk-helper
