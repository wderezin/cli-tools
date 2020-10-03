
function _shell_bin_dirs
  for SHELL in python2 python3 node bash zsh fish
    if type $SHELL >/dev/null 2>&1
      echo "$DARING_CLI_TOOLS_DIR/by_shell/$SHELL/bin"
    end
  end
end
