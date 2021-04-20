% SIGNTOS(1)
% The Android Open Source Project

# NAME

signtos - signing tool for signing Trusty images

# SYNOPSIS

Command line tool from Android for signing Trusty image files:

**signtos** [-providerClass _className_] _privatekey.pk8_ _input.img_ _output.img_

# DESCRIPTION

Signs ARM Trusty images for use with operating systems that support
it. Trusty is a set of software components supporting a Trusted
Execution Environment (TEE) on mobile devices.  The key must be stored
in PKCS#8 format.

# SEE ALSO

SIGNAPK(1)

https://source.android.com/security/trusty/
