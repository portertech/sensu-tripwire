#!/bin/sh
set -e

DIR=$(dirname "$0")
TWDIR=/tmp/tw

CFGT=$TWDIR/twcfg.txt
POLT=$TWDIR/twpol.txt
CFG=$TWDIR/tw.cfg
POL=$TWDIR/tw.pol
SKEY=$TWDIR/site.key
LKEY=$TWDIR/local.key
PASS=password
DB=$TWDIR/db.twd
REP=$TWDIR/report-latest.twr

if [[ -e $DB ]]; then
    echo "Tripwire DB already initialized"
    exit 0
fi

mkdir -p $TWDIR

cat > $CFGT <<- EOM
ROOT                   =/
POLFILE                =$POL
DBFILE                 =$DB
REPORTFILE             =$REP
SITEKEYFILE            =$SKEY
LOCALKEYFILE           =$LKEY
EDITOR                 =/usr/bin/vi
LATEPROMPTING          =false
LOOSEDIRECTORYCHECKING =false
MAILNOVIOLATIONS       =true
EMAILREPORTLEVEL       =3
REPORTLEVEL            =3
MAILMETHOD             =SENDMAIL
SYSLOGREPORTING        =false
MAILPROGRAM            =/usr/sbin/sendmail -oi -t
EOM

cat > $POLT <<- "EOM"
  ##############################################################################
 #                                                                            ##
############################################################################## #
#                                                                            # #
#                    Tripwire 2.4 policy for Linux (RPM)                     # #
#                             updated March 2018                             # #
#                                                                            ##
##############################################################################

  ##############################################################################
 #                                                                            ##
############################################################################## #
#                                                                            # #
# Global Variable Definitions                                                # #
#                                                                            # #
# These are defined at install time by the installation script.  You may     # #
# Manually edit these if you are using this file directly and not from the   # #
# installation script itself.                                                # #
#                                                                            ##
##############################################################################

@@section GLOBAL

  ##############################################################################
 #  Predefined Variables                                                      #
##############################################################################
#
#  Property Masks
#
#  -  ignore the following properties
#  +  check the following properties
#
#  a  access timestamp (mutually exclusive with +CMSH)
#  b  number of blocks allocated
#  c  inode creation/modification timestamp
#  d  ID of device on which inode resides
#  g  group id of owner
#  i  inode number
#  l  growing files (logfiles for example)
#  m  modification timestamp
#  n  number of links
#  p  permission and file mode bits
#  r  ID of device pointed to by inode (valid only for device objects)
#  s  file size
#  t  file type
#  u  user id of owner
#
#  C  CRC-32 hash
#  H  HAVAL hash
#  M  MD5 hash
#  S  SHA hash
#
##############################################################################

SEC_DEVICE        = +pugsdr-intlbamcCMSH ;
SEC_DYNAMIC       = +pinugtd-srlbamcCMSH ;
SEC_GROWING       = +pinugtdl-srbamcCMSH ;
SEC_IGNORE_ALL    = -pinugtsdrlbamcCMSH ;
SEC_IGNORE_NONE    = +pinugtsdrbamcCMSH-l ;
SEC_READONLY      = +pinugtsdbmCM-rlacSH ;
SEC_TEMPORARY       = +pugt ;

@@section FS

  ################################################
 #                                              ##
################################################ #
#                                              # #
#  RPM Checksum Files                          # #
#                                              ##
################################################
(
  rulename = "RPM Checksum Files",
)
{
  /var/lib/rpm                  -> $(SEC_READONLY);
  /var/lib/rpm/__db.001         -> $(SEC_DYNAMIC) ;
  /var/lib/rpm/__db.002         -> $(SEC_DYNAMIC) ;
  /var/lib/rpm/__db.003         -> $(SEC_DYNAMIC) ;
}

  ################################################
 #                                              ##
################################################ #
#                                              # #
#  Global Configuration Files (/etc/)          # #
#                                              ##
################################################
(
  rulename = "Global Configuration Files",
)
{
  /etc                           -> $(SEC_IGNORE_NONE) -SHa ;
  /etc/adjtime                   -> $(SEC_DYNAMIC) ;
  /etc/aliases.db                -> $(SEC_DYNAMIC) ;
  /etc/bashrc                    -> $(SEC_DYNAMIC) ;
  /etc/csh.cshrc                 -> $(SEC_DYNAMIC) ;
  /etc/csh.login                 -> $(SEC_DYNAMIC) ;
  /etc/mail/statistics           -> $(SEC_GROWING) ;
  /etc/profile                   -> $(SEC_DYNAMIC) -i ;
  /etc/mtab                      -> $(SEC_DYNAMIC) -i ;
  /etc/rc.d                      -> $(SEC_IGNORE_NONE) -SHa ;
  /etc/sysconfig                 -> $(SEC_IGNORE_NONE) -SHa ;
  /etc/sysconfig/hwconf          -> $(SEC_DYNAMIC) -m ;
}

  ################################################
 #                                              ##
################################################ #
#                                              # #
#  OS Boot Files and Mount Points              # #
#                                              ##
################################################
(
  rulename = "OS Boot Files and Mount Points",
)
{
  /boot                         -> $(SEC_READONLY) ;
  /cdrom                        -> $(SEC_DYNAMIC) ;
  /floppy                       -> $(SEC_DYNAMIC) ;
  /mnt                          -> $(SEC_DYNAMIC) ;
}

  ################################################
 #                                              ##
################################################ #
#                                              # #
#   OS Devices and Misc Directories            # #
#                                              ##
################################################
(
  rulename = "OS Devices and Misc Directories",
)
{
  /dev                          -> $(SEC_DEVICE) ;
  /initrd                       -> $(SEC_DYNAMIC) ;
  /opt                          -> $(SEC_DYNAMIC) ;
  /lost+found                   -> $(SEC_DYNAMIC) ;
  /var/lost+found               -> $(SEC_DYNAMIC) ;
  /home/lost+found              -> $(SEC_DYNAMIC) ;
  !/dev/pts ;                    # Ignore this file
  !/dev/shm ;                    # Ignore this file
}

  ################################################
 #                                              ##
################################################ #
#                                              # #
#  OS Binaries and Libraries                   # #
#                                              ##
################################################
(
  rulename = "OS Binaries and Libraries",
)
{
  /bin                          -> $(SEC_READONLY) ;
  /lib                          -> $(SEC_READONLY) ;
  /sbin                         -> $(SEC_READONLY) ;
  /usr/bin                      -> $(SEC_READONLY) ;
  /usr/lib                      -> $(SEC_READONLY) ;
  /usr/libexec                  -> $(SEC_READONLY) ;
  /usr/sbin                     -> $(SEC_READONLY) ;
  /usr/X11R6/lib                -> $(SEC_READONLY) ;
}
  ################################################
 #                                              ##
################################################ #
#                                              # #
#  User Binaries and Libraries                 # #
#                                              ##
################################################
(
  rulename = "User Binaries and Libraries",
)
{
  !/home/local;
  /usr/local                    -> $(SEC_READONLY) ;
  /usr/local/bin                -> $(SEC_READONLY) ;
  /usr/local/doc                -> $(SEC_READONLY) ;
  /usr/local/etc                -> $(SEC_READONLY) ;
  /usr/local/games              -> $(SEC_READONLY) ;
  /usr/local/include            -> $(SEC_READONLY) ;
  /usr/local/lib                -> $(SEC_READONLY) ;
  /usr/local/libexec            -> $(SEC_READONLY) ;
  /usr/local/man                -> $(SEC_READONLY) ;
  /usr/local/sbin               -> $(SEC_READONLY) ;
  /usr/local/share              -> $(SEC_READONLY) ;
  /usr/local/src                -> $(SEC_READONLY) ;
  /usr/local/sysinfo            -> $(SEC_READONLY) ;
}

  ################################################
 #                                              ##
################################################ #
#                                              # #
#  Root Directory and Files                    # #
#                                              ##
################################################
(
  rulename = "Root Directory and Files",
)
{
  /root                         -> $(SEC_IGNORE_NONE) -SHa ;
  /root/.bashrc                 -> $(SEC_DYNAMIC) ;
  /root/.bash_history           -> $(SEC_DYNAMIC) ;
  #/root/.bash_logout            -> $(SEC_DYNAMIC) ;
  /root/.bash_profile           -> $(SEC_DYNAMIC) ;
  /root/.cshrc                  -> $(SEC_DYNAMIC) ;
  #/root/.enlightenment          -> $(SEC_DYNAMIC) ;
  #/root/.esd-auth               -> $(SEC_DYNAMIC) ;
  !/root/.gconf ;
  !/root/.gconfd ;
  #/root/.gnome                  -> $(SEC_DYNAMIC) ;
  #/root/.gnome-desktop          -> $(SEC_DYNAMIC) ;
  #/root/.gnome2                 -> $(SEC_DYNAMIC) ;
  #/root/.gtkrc                  -> $(SEC_DYNAMIC) ;
  #/root/.gtkrc-1.2-gnome2       -> $(SEC_DYNAMIC) ;
  #/root/.metacity               -> $(SEC_DYNAMIC) ;
  #/root/.nautilus               -> $(SEC_DYNAMIC) ;
  #/root/.rhn-applet.conf        -> $(SEC_DYNAMIC) ;
  #/root/.tcshrc                 -> $(SEC_DYNAMIC) ;
  #/root/.xauth                  -> $(SEC_DYNAMIC) ;
  #/root/.ICEauthority           -> $(SEC_DYNAMIC) ;
  #/root/.Xauthority             -> $(SEC_DYNAMIC) -i ;
  #/root/.Xresources             -> $(SEC_DYNAMIC) ;
}

  ################################################
 #                                              ##
################################################ #
#                                              # #
#  Temporary Directories                       # #
#                                              ##
################################################
(
  rulename = "Temporary Directories",
)
{
  /usr/tmp                      -> $(SEC_TEMPORARY) ;
  /var/tmp                      -> $(SEC_TEMPORARY) ;
  /tmp                          -> $(SEC_TEMPORARY) ;
  #/tmp/.fam-socket              -> $(SEC_TEMPORARY) ;
  #/tmp/.ICE-unix                -> $(SEC_TEMPORARY) ;
  #/tmp/.X11-unix                -> $(SEC_TEMPORARY) ;
  !/tmp/orbit-root ;
}

  ################################################
 #                                              ##
################################################ #
#                                              # #
#  System Boot Changes                         # #
#                                              ##
################################################
(
  rulename = "System Boot Changes",
)
{
  /.autofsck                    -> $(SEC_DYNAMIC) -m ;
  /var/cache/man/whatis         -> $(SEC_GROWING) ;
  /var/lib/logrotate.status     -> $(SEC_GROWING) ;
  #/var/lib/nfs/statd            -> $(SEC_GROWING) ;
  !/var/lib/random-seed ;
  #/var/lib/slocate/slocate.db    -> $(SEC_GROWING) -is ;
  /var/lock/subsys                -> $(SEC_DYNAMIC) -i ;
  /var/log                        -> $(SEC_GROWING) -i ;
  !/var/log/sa;
  !/var/log/cisco;
  /var/run                        -> $(SEC_DYNAMIC) -i ;
  /etc/cron.daily                 -> $(SEC_GROWING);
  /etc/cron.weekly                -> $(SEC_GROWING);
  /etc/cron.monthly               -> $(SEC_GROWING);
  /var/spool/mail                 -> $(SEC_GROWING);
}

  ################################################
 #                                              ##
################################################ #
#                                              # #
#  Monitor Filesystems                         # #
#                                              ##
################################################
(
  rulename = "Monitor Filesystems",
)
{
  /                             -> $(SEC_READONLY) ;
  /home                         -> $(SEC_READONLY) ;  # Modify as needed
  /usr                          -> $(SEC_READONLY) ;
  /var                          -> $(SEC_READONLY) ;
}

  ################################################
 #                                              ##
################################################ #
#                                              # #
#   Proc Filesystem                            # #
#                                              ##
################################################
(
   rulename = "Proc Filesystem",
)
{
   !/proc ;                           # Ignore most of this directory
}
EOM

$DIR/twadmin --generate-keys -S $SKEY -Q $PASS

$DIR/twadmin --generate-keys -L $LKEY -P $PASS

$DIR/twadmin --create-cfgfile -c $CFG -e $CFGT

$DIR/twadmin --create-polfile -c $CFG -e $POLT

$DIR/tripwire --init -c $CFG -e
