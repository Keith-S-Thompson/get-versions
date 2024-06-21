Copyright © 2024 Keith Thompson

`get-versions` is released under GPL version 2 or later.  See the
header comments in `get-versions` and the file `COPYING`.

`get-versions` is a command-line utility that will fetch multiple
versions of a file stored in an
[RCS](https://www.gnu.org/software/rcs/),
[CVS](https://www.nongnu.org/cvs/),
[SVN (Subversion)](https://subversion.apache.org/), or
[Git](https://git-scm.com/)
repository. It has a number of options (perhaps too many!) to control
which versions to fetch, how to name the resulting files, and so forth.

It does not currently support other version control systems.
I'll consider adding support for other systems in the future,
particularly Mercurial/hg (though I don't use Mecurial these days,
so don't expect that soon).

By default, `get-versions` uses a comma to separate the file name from
the version number.  For example, if you're in a CVS directory tree,
this command:

Note that the `gpm` (General Purpose Mouse interface) package provides
a `/usr/bin/get-versions` command which might conflict with this,
depending on how your `$PATH` is configured.

```
get-versions foo.txt 1.3-1.5
```

or

```
get-versions foo.txt 1.3..1.5
```

will create the following files

```
foo.txt,1.3
foo.txt,1.4
foo.txt,1.5
```

That's not very friendly for Windows systems, which depend on the
file extension to identify file types, so this command:

```
get-versions -windows foo.txt 1.3-1.5
```

or, equivalently,

```
get-versions -infix -delimiter __ foo.txt 1.3-1.5
```

will create the following files:

```
foo__1.3.txt
foo__1.4.txt
foo__1.5.txt
```

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

Run `get-versions -help` to see a short usage message:

```
get-versions: Get specified revisions of a file from a version control system
Currently supported systems are RCS, CVS, SVN, and Git
Usage: get-versions [options] file [revision...]
Option names may be abbreviated uniquely
Options:
    -help, usage Display this short help message and exit
    -long-help   Display a long help message
                 Suggest `get-versions -long-help | less`
    -format-help Show documentation for the -format option
                 Also -fmt-help, -help-format, -help-fmt
```

Run `get-versions -long-help` to see a longer usage message:

```
get-versions: Get specified revisions of a file from a version control system
Currently supported systems are RCS, CVS, SVN, and Git
Usage: get-versions [options] file [revision...]
Option names may be abbreviated uniquely
Options:
    -help, usage Display this short help message and exit
    -long-help   Display a long help message
                 Suggest `get-versions -long-help | less`
    -format-help Show documentation for the -format option
                 Also -fmt-help, -help-format, -help-fmt
```

Run `get-versions -format-help` for documentation on the `-format` option:

```
get-versions -format ...
The -format (or -fmt) option takes a printf-like format string to
specify the name of the created file.

%n    expands to an integer sequence number, starting with 1 for the
      oldest revision.  %3n, for example, pads with leading 0s to
      3 digits.
%t    expands to a timestamp in the form "YYYY-MM-DD-hhmmss"
      A number specifies the number of fields, 1..6.
      For example %3t yields "YYYY-MM-DD"; %5t yields "YYYY-MM-DD-hhmm".
%rt   expands to a raw timestamp, integer seconds since 1970
%h    expands to the hash.  %8h, for example, expands to the first 8
      digits of the hash.  %h gives the full 40-character hash.
%f    expands to the original file name
%p    expands to the prefix of the original file name, defined as
      everything up to and not including the last '.' character.
      If there is no '.'  character, expands to the entire file name.
%s    expands to the suffix (extension) of the original file name,
      defined as everything including and after the last '.' character.
      If there is no '.'  character, expands to nothing.
      %p does not include the '.'; %s does.
      %p%s is equivalent to %f.
%d    expands to the delimiter; the default ',' can be overridden by
      the -delimiter option
%%    expands to a single '%' character
Other characters (including '%') are passed through unchanged.

For example, `get-versions -format '%p__%03n.%s' foo.txt`
might create `foo__001.txt`, `foo__002.txt`, etc.
```

-- Keith Thompson <Keith.S.Thompson@gmail.com> Wed 2023-12-20
