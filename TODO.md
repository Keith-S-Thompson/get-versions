TODO:

* Optionally set mtime for systems other than RCS (get info from log).
  Make it optional for RCS (it currently forces -mtime to be set).

* Support Mecurial/hg.

* Apply more options to all forms of repository:
  * -bytimestamp/bydate, -utc, -raw
  * -last n

* Recognize more numeric options, up to -9

* For git, specify one or more versions of a file, for example<br>
  `get-versions foo.c ec5598465cac4d58b57c9587c5a1b1b57358fc7f`
