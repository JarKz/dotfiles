def --env yy [] {
  let tmp = mktemp -t 'yazi-cwd.XXXXXX'
  yazi "$@" --cwd-file=$"($tmp)"
  let cwd = cat $tmp

  if ($cwd | is-not-empty) and $cwd != $env.PWD {
    cd $cwd
  }

  rm -f $tmp
}
