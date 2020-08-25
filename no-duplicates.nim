import tables
from os import commandLineParams, getAppFilename
from terminal import isatty

proc main = 
  let input = if isatty(stdin):
    let cmd_args = commandLineParams()
    if cmd_args.len < 1 or cmd_args.contains("-h"):
      echo "Usage: ", getAppFilename(), " <file>"
      quit(1)

    open(cmd_args[^1])
  else:
    stdin
  defer: close(input)

  var strings  = initCountTable[string]()
  for line in input.lines:
    if line notin strings:
      strings.inc(line)
      echo line

main()
