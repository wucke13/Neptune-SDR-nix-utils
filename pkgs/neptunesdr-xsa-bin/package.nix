{ runCommand }:

runCommand "copy-xsa" { } ''
  mkdir -- "$out"
  cp -- ${./system_top.xsa} "$out/"
''
