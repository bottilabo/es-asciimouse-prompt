# es-asciimouse-prompt
#
# based on theme-es(https://github.com/oh-my-fish/theme-es) 
# modified by bottilabo (twitter @bottilabo)
#
# ASCIImouse is created by ROM子 (twitter @riv_mk)
# - https://twitter.com/asciimouse 
#
# Nerd fonts are required

set -g CMD_DURATION 0

. ./es-asciimouse.fish

function _UserSymbol
  if test (id -u $USER) -eq 0
    echo 'root (((ᘛ ⁐̤ ᕐᐷ)))'
  else
    echo "$USER ᘛ ⁐̤ ᕐᐷ"
  end
end

function _UserDiv
  set -l i 2
  if test (id -u $USER) -eq 0
      set i 1
  end

  if test "$argv[1]"
    echo $pwlndiv1a[$i]' '
  else
    echo $pwlndiv1b[$i]' '
  end
end

function __no_escseq
    #cat | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"
    #cat | perl -pe 's/\e\[[;\d]+[mk]//g' | sed -r "s/\x1B\[m//g"
    cat | perl -pe 's/\e\[[;\d]+[mk]//g' | sed -r "s/\x1B\[m//g" | sed -r "s/\x1B\(B//g"
end

function fish_prompt
  set -l p_path2 ''

  #set -l pwcol (echo $fish_color_selection | sed -e 's/^.*--background=\([^ ]\)/\1/')
  if [ "$USER" = "root" ]
    set p_path2 (set_color $fish_color_error)(set_color --background $pwln3)$PWD' '(_col_res)(set_color $pwln3)(_UserDiv)(_col_res)            #path shortened to last two folders ($count)
  else
      set p_path2 (set_color $fish_color_selection)(set_color --background $pwln3)$PWD' '(_col_res)(set_color $pwln3)(_UserDiv)(_col_res)' '            #path shortened to last two folders ($count)
  end
  
  set -g last_status $status                                         #exit status of last command
  set -l symbols ''                                                  #add some pre-path symbols
  if [ $symbols_style = 'symbols' ]
    if [ ! -w . ];    set symbols $symbols(set_color $fish_color_cancel) ;           end
    if set -q -x VIM; set symbols $symbols(set_color $fish_color_comment)$ICON_VIM ; end
    if set -q -x RANGER_LEVEL; set symbols $symbols(set_color $fish_color_comment)$ICON_RANGER ; end
  end

  if [ -n "$symbols" ]
    set symbols $symbols" "
  end

  set -l pwdt (set_color blue --background $pwln1)' '(date '+%Y/%m/%d %H:%M:%S')' '(set_color $pwln1 --background $pwln2)''

  set dirty ' '
  if [ "$USER" = "root" ]
    set prompt (echo $pwdt)(set_color $fish_color_error --background $pwln2)"$dirty"(_UserSymbol)' '(_col_res)(set_color $pwln2)(_UserDiv)(_col_res)' '
  else
    set prompt (echo $pwdt)(set_color $fish_color_quote --background $pwln2)"$dirty"(_UserSymbol)' '(_col_res)(set_color $pwln2)(_UserDiv)(_col_res)' '
  end
 
  set -l gitprompt (__fish_git_prompt)
  if test -n "$gitprompt"
    set gitprompt "$ICON_BRANCH"$gitprompt' '(set_color $pwln3)(_UserDiv 1)
  end
  set -l prompt2 (__prompt2)
  if test -n "$prompt2"
    set prompt2 $prompt2'  '(set_color $pwln3)(_UserDiv 1)
  end

  set -l ssh_prompt ''
  if test -n "$SSH_CONNECTION"
    set -l MODCOLMN (expr $COLUMNS - 0)
    set -l tkn (string split ' ' "$SSH_CONNECTION")
    set ssh_prompt (set_color $pwln4 --background normal)''(set_color $pwln4)" remote: "(hostname)' '(_col_res)(set_color $pwln4 --background normal)''(set_color black --background $pwln4)" SSH $tkn[3]:$tkn[4] from $tkn[1] "(_col_res)
    if test (string length -- (echo $symbols$p_path2"$gitprompt$prompt2$ssh_prompt" | __no_escseq)) -ge $MODCOLMN
      set ssh_prompt (set_color $pwln4 --background normal)''(set_color $pwln4)" remote: "(hostname)' '(_col_res)(set_color $pwln4 --background normal)''(set_color black --background $pwln4)" SSH $tkn[3]:$tkn[4] "(_col_res)
    end
    if test (string length -- (echo $symbols$p_path2"$gitprompt$prompt2$ssh_prompt" | __no_escseq)) -ge $MODCOLMN
      set ssh_prompt (set_color $pwln4 --background normal)''(set_color $pwln4)" remote: "(hostname)' '(_col_res)(set_color $pwln4 --background normal)(_col_res)
    end
    if test (string length -- (echo $symbols$p_path2"$gitprompt$prompt2$ssh_prompt" | __no_escseq)) -ge $MODCOLMN
      set ssh_prompt (set_color $pwln4 --background normal)''(set_color $pwln4)(hostname)' '(_col_res)(set_color $pwln4 --background normal)(_col_res)
    end
  end

  echo -s (_col_res)$symbols$p_path2"$gitprompt$prompt2$ssh_prompt"
  echo -n -s $prompt
end

function __postexec --on-event fish_postexec
  set -l st $status
  set_color $fish_color_comment
  #echo -n (__htime $CMD_DURATION)
  __prompt3
  if [ "$st" = "0" ]
    set_color $fish_color_command
  else
    set_color $fish_color_error
  end
  if [ -n "$argv" ]
    echo " $st = "(set_color $fish_color_comment)"$argv"
  end
end

function __prompt3
  set -l duration (_cmd_duration)                                    #set duration of last command
  if [ (jobs -l | wc -l) -gt 0 ]                                     #set ⚙ if any background jobs exit
    set jobsp $ICON_JOBS
  end
  echo -n -s "$errorp$duration$jobsp"                                #show error code, command duration and jobs status
end

function __prompt2
  # if _is_git_folder                                                  #show  only if in a git folder
  # #command git rev-parse --is-inside-work-tree 1>/dev/null 2>/dev/null
  #   set git_sha (_git_prompt_short_sha)                              #git short sha
  # end
  set NODEp   (_node_version)                                      #Node.js version
  set PYTHONp (_python_version)                                    #Python version
  set RUBYp   (_ruby_version)                                      #Ruby prompt @ gemset
  echo -n -s "$NODEp$PYTHONp$RUBYp"                        # -n no newline -s no space separation
  #echo -n -s (_prompt_user)                                          #display user@host if different from default or SSH
end

function __htime
  set -l days ''; set -l hours ''; set -l minutes ''; set -l seconds ''
  set -l duration (expr $argv[1] / 1000)
  if [ $duration -gt 0 ]
    set seconds (expr $duration \% 68400 \% 3600 \% 60)'s'
    if [ $duration -ge 60 ]
      set minutes (expr $duration \% 68400 \% 3600 / 60)'m'
      if [ $duration -ge 3600 ]
        set hours (expr $duration \% 68400 / 3600)'h'
        if [ $duration -ge 68400 ]
          set days (expr $duration / 68400)'d'
        end
      end
    end
    set duration $days$hours$minutes$seconds
    echo '('$duration')'
  else
    echo ''
  end
end

function _cmd_duration -d 'Displays the elapsed time of last command and show notification for long lasting commands'
  set -l duration (__htime $CMD_DURATION) 
  if [ $last_status -ne 0 ]
    echo -n (_col brred)$duration(_col_res)
  else
    echo -n (_col brgreen)$duration(_col_res)
  end
end


function _col                                     #Set Color 'name b u' bold, underline
  set -l col; set -l bold; set -l under
  if [ -n "$argv[1]" ];       set col   $argv[1]; end
  if [ (count $argv) -gt 1 ]; set bold  "-"(string replace b o $argv[2] 2>/dev/null); end
  if [ (count $argv) -gt 2 ]; set under "-"$argv[3]; end
  set_color $bold $under $argv[1]
end
function _col_res -d "Rest background and foreground colors"
  set_color -b normal
  set_color normal
end

function prompt_pwd2
  set realhome ~
  set -l _tmp (string replace -r '^'"$realhome"'($|/)' '~$1' $PWD)  #replace $HOME with '~' in path
  set -l _tmp2 (basename (dirname $_tmp))/(basename $_tmp)          #get last two dirs from path
  echo (string trim -l -c=/ (string replace "./~" "~" $_tmp2))      #trim left '/' or './' for special cases
end
function prompt_pwd_full
  set -q fish_prompt_pwd_dir_length; or set -l fish_prompt_pwd_dir_length 1
  if [ $fish_prompt_pwd_dir_length -eq 0 ]
    set -l fish_prompt_pwd_dir_length 99999
  end
  set -l realhome ~
  echo $PWD | sed -e "s|^$realhome|~|" -e 's-\([^/.]{'"$fish_prompt_pwd_dir_length"'}\)[^/]*/-\1/-g'
end

function _file_count
  ls -1 | wc -l | sed 's/\ //g'
end

function _node_version -d "Get the currently used node version if NVM exists"
  set -l node_version
  type -q nvm; and set node_version (string trim -l -c=v (node -v 2>/dev/null)) # trimmed lef 'v'; can use 'nvm current', but slower
  test $node_version; and echo -n -s (_col brgreen)$ICON_NODE(_col green)$node_version(_col_res)
end

function _ruby_version -d "Get RVM or rbenv version and output" #2>&1 stderr2stdout, >&2 vice versa, '>' stdout, '2>' stderr
  set -l ruby_ver
  if which rvm-prompt >/dev/null 2>&1
    set ruby_ver (rvm-prompt i v g)
  else
    if which rbenv >/dev/null 2>&1
      set ruby_ver (rbenv version-name)
    end
  end
  if test -n (_rbenv_gemset 2>/dev/null; or echo "")
    test $ruby_ver; and echo -n -s (_col brred)$ICON_RUBY(_col green)$ruby_ver(_col grey)"@"(_col brgrey)(_rbenv_gemset)(_col_res)
  else
    test $ruby_ver; and echo -n -s (_col brred)$ICON_RUBY(_col green)$ruby_ver(_col_res)
  end
end

function _rbenv_gemset -d "Get main current gemset name"
  if type -q rbenv
    if test (rbenv gemset active 2>/dev/null)                           #redirects stderr to /null
      set -l active_gemset (string split -m1 " " (rbenv gemset active))
      echo -n -s $active_gemset[1]
    else
      echo ''
    end
  else
    echo ''
  end
end

function _python_version -d "Get python version if pyenv is installed"
  set -l python_version
  if which pyenv >/dev/null 2>&1
    if test -f .python-version
      set python_version (pyenv version-name)
    end
    if [ "$python_version" = "system" ]
        set python_version ''
    end
  end
  test $python_version; and echo -n -s (_col brblue)$ICON_PYTHON(_col green)$python_version(_col_res)
end

