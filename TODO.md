TODO:

NOTE: Any items that apply to systems other than Git have a low
priority.

* Optionally set mtime for systems other than RCS (get info from log).
  Make it optional for RCS (it currently forces -mtime to be set).
* Support Mercurial/hg.  Use `hg cat filename -r revision`; see
  [this question](http://stackoverflow.com/q/4523918/827263) on Stack Overflow.
  Also figure out how to make checked out files executable if appropriate.
* Apply more options to all forms of repository:
  * -bytimestamp/bydate, -utc, -raw
  * -last n
  * For CVS: -all to get all revisions listed in `cvs log` output
* Recognize more numeric options, up to -9 (largely handled by `-format` option)
* For git, specify one or more versions of a file, for example  
  `get-versions -byhash foo.c ec5598465cac4d58b57c9587c5a1b1b57358fc7f`
* For git, specify a range of versions, for example  
  `get-versions -byhash foo.c commit1..commit2`  
  For `git log`, this range does not include `commit1` but does include `commit2`.
  I think I want to include both.
* For git, make checked out files executable if appropriate.
  Use `git ls-tree revision filename` to determine this.
* BUG: For CVS, `get-versions nosuchfile 1.1` creates an empty
  `nosuchfile,1.1` and no error or warning message.
* Simplify the implementation by re-implementing most options
  as front ends for the `-format` option.
* Revamp the `-help` option to show a terser usage message by
  default, with options to show more complete help including
  a man page (using `Pod::Usage`).  
  Partially done.  I now have `-help` showing a short usage message,
  and `-long-help` showing the full usage message (plus `format-help`
  for the `-format` option).  Still TODO: Use `Pod::Usage`.
