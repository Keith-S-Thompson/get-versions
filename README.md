Copyright (C) 2016 Keith Thompson

`get-versions` is released under GPL version 2 or later.  See the
header comments in `get-versions` and the file `COPYING`.

`get-versions` is a command-line utility that will fetch multiple
versions of a file stored in an
[RCS](http://www.gnu.org/software/rcs/),
[CVS](http://www.nongnu.org/cvs/),
[SVN (Subversion)](http://subversion.apache.org/), or
[Git](http://git-scm.com/)
repository. It has a number of options (perhaps too many!) to control
which versions to fetch, how to name the resulting files, and so forth.

It does not currently support other version control systems.
I'll consider adding support for other systems in the future,
particularly Mercurial/hg.

By default, `get-versions` uses a comma to separate the file name from
the version number.  For example, if you're in a CVS directory tree,
this command:

    get-versions foo.txt 1.3-1.5

or

    get-versions foo.txt 1.3..1.5

will create the following files

    foo.txt,1.3
    foo.txt,1.4
    foo.txt,1.5

That's not very friendly for Windows systems, which depend on the
file extension to identify file types, so this command:

    get-versions -windows foo.txt 1.3-1.5

or, equivalently, 

    get-versions -infix -delimiter __ foo.txt 1.3-1.5

will create the following files:

    foo__1.3.txt
    foo__1.4.txt
    foo__1.5.txt

maintaining the `.txt` suffix and avoiding the use of the comma
delimiter.

For SVN, version numbers are integers with no decimal points,
incremented for each commit to the repository.  Versions that don't
apply to the current file are skipped; for example, a given file
might have revisions 1, 2, 5, and 7.

Since git doesn't assign version numbers to individual files,
the behavior for git is a bit different.  It arbitrarily assigns
sequential versions, starting at 1, to all the revisions shown by the
`git log` command.  The file names can include some combination of
this sequential version number, the (possibly abbreviated) hash,
and the timestamp.

Some command-line options are specific to certain version control
systems.  This is not always enforced; in some cases, meaningless
options are treated as errors, and in other cases they're silently
ignored.

I've been developing this tool for my own personal use since 1991.
I might later add the full revision history to this GitHub project; for
now, I'm just adding the current version and developing it from there.

Run `get-versions -help` to see a usage message:

    get-versions: get specified revisions of a file from a version control system
    Currently supported systems are RCS, CVS, SVN, and Git
    Usage: get-versions [options] file [revision...]
    Option names may be abbreviated uniquely
    Options:
        -help, usage Display this message and exit
        -rcs         Use RCS (default if there's an RCS directory)
        -cvs         Use CVS (default if there's a CVS directory)
        -svn         Use SVN (default if there's a .svn directory)
        -git         Use Git (default if there's a .git directory
                              in the current directory or any parent)
        NOTE: If more than one default is available, the method must be specified
        -bynumber    Git only: assign numbers starting at 0 to use as the version
                     This is the default
                     Affected by "-padding"
        -bytimestamp Git only: use the timestamp as the version
        -bydate      Alias for -bytimestamp
        -utc         With -bytimestamp, use UTC
        -raw         With -bytimestamp, use raw Unix time
        -byhash      Git only: use the hash as the version
                     More than one of the -by* options can be given if you
                     like very long file names.
        -hash-length n  With "-byhash", use only the first n characters of the hash
        -hash8       Equivalent to -padding 3 -bynumber -byhash -hash-length 8
        -follow      Git only: Pass "--follow" option to "git log".
                     This doesn't currently work.
        -last n      Get only last n versions (git only for now)
        -delimiter s Use the specified delimiter; default is ","
        -infix       Place the version number before the file suffix,
                     e.g., "foo,1.23.jpg" rather than "foo.jpg,1.23".
        -windows     Use options appropriate for Windows:
                         -infix -delimiter __ 
        -padding n   Pad last field of revision to n digits; default is 0.
        -2           Equivalent to "-padding 2"
        -3           Equivalent to "-padding 3"
        -mtime       Set modification time of file to the date of the
                     retrieved revision.  Currently supported only for RCS.
                     Default is true for RCS, false for CVS.
        -quiet       Send RCS/CVS messages to /dev/null
        -trace       Show each command before executing it
        -debugging   Lotsa debugging output (not recommended)
    Each revision argument may specify either a single revision (numeric
    or symbolic), a range of numeric revisions separated by a '-' or '..', or
    a numeric revision followed by a '-' or '..' (indicating a range from the
    specified revision to the head (latest) revision).
    
    RCS and CVS revisions are sequences of decimal integers separated by
    '.', for example "1.42".  In the absence of branches, "1.1-" denotes
    the complete history.
    SVN revisions are decimal integers.  Any revisions that do not apply to
    a particular file are skipped. "1-" denotes the complete history.
    Git revisions are 40-digit hexadecimal SHA-1 hashes.  This program
    can use hashes, dates, or small integers to denote versions.
    
    Example: get-versions -2 .bashrc 1.5-1.7 1.10          # CVS
             get-versions -2 .bashrc 1.5..1.7 1.10
             creates the following files in the current directory:
                .bashrc,1.05
                .bashrc,1.06
                .bashrc,1.07
                .bashrc,1.10
    Example: get-versions -infix -delim __ 1.7 foo.dat
             creates the following file:
                foo__1.7.dat

-- Keith Thompson <Keith.S.Thompson@gmail.com> Thu 2016-04-21
