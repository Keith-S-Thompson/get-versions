TODO:

* Optionally set mtime for systems other than RCS (get info from log).
  Make it optional for RCS (it currently forces -mtime to be set).

* Support Mecurial/hg.

* Apply more options to all forms of repository:
  * -bytimestamp/bydate, -utc, -raw
  * -last n
  * For CVS: -all to get all revisions listed in `cvs log` output

* Recognize more numeric options, up to -9

* For git, specify one or more versions of a file, for example  
  `get-versions -byhash foo.c ec5598465cac4d58b57c9587c5a1b1b57358fc7f`

* For CVS, `get-versions nosuchfile 1.1` creates an empty
  `nosuchfile,1.1` and no error or warning message.
