function gcd --description 'git cd relative to the git root directory'
  if test "$argv" = "-"
    cd -
  else if test "$argv" != ""
    cd (git rev-parse --show-toplevel)/$argv
  else
    cd (git rev-parse --show-toplevel)
  end
end
