function __init_es_asciimouse_prompt
    
# Global variables that affect how left and right prompts look like
set -g symbols_style                   'symbols'
set -g theme_display_git_ahead_verbose  yes
set -g theme_hide_hostname              no
set -g theme_display_user               no

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_untrackedfiles '☡'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '+'
set __fish_git_prompt_char_upstream_behind '-'

# powerline
set -g pwln1 50c0f0
set -g pwln2 3080e0
set -g pwln3 2050c0
set -g pwln4 e08030

set -g pwlndiv1a '' ""
set -g pwlndiv1b '' ""

#echo \Uf00a \ue709 \ue791 \ue739 \uF0DD \UF020 \UF01F \UF07B \UF015 \UF00C \UF00B \UF06B \UF06C \UF06E \UF091 \UF02C \UF026 \UF06D \UF0CF \UF03A \UF03D \UF081 \UF02A \UE606 \UE73C      #\UF005 bugs in fish
set -g ORANGE                     FF8C00        #FF8C00 dark orange, FFA500 orange, another one fa0 o
set -g ICON_NODE                  \UE718" "     #  from Devicons or ⬢
set -g ICON_RUBY                  \UE791" "     # \UE791 from Devicons; \UF047; \UE739; 💎
set -g ICON_PYTHON                \UE606" "     # \UE606; \UE73C
#set -g ICON_PERL                  \UE606" "     # \UE606; \UE73C
set -g ICON_TEST                  \UF091        # 
set -g ICON_VCS_UNTRACKED         \UF02C" "     #    #●: there are untracked (new) files
set -g ICON_VCS_UNMERGED          \UF026" "     #    #═: there are unmerged commits
set -g ICON_VCS_MODIFIED          \UF06D" "     # 
set -g ICON_VCS_STAGED            \UF06B" "     #  (added) →
set -g ICON_VCS_DELETED           \UF06C" "     # 
set -g ICON_VCS_DIFF              \UF06B" "     # 
set -g ICON_VCS_RENAME            \UF06E" "     # 
set -g ICON_VCS_STASH             \UF0CF" "     #      #✭: there are stashed commits
set -g ICON_VCS_INCOMING_CHANGES  \UF00B" "     #  or \UE1EB or \UE131
set -g ICON_VCS_OUTGOING_CHANGES  \UF00C" "     #  or \UE1EC or 
set -g ICON_VCS_TAG               \UF015" "     # 
set -g ICON_VCS_BOOKMARK          \UF07B" "     # 
set -g ICON_VCS_COMMIT            \UF01F" "     # 
set -g ICON_VCS_BRANCH            \UE0A0        # \UE0A0 or \UF020
set -g ICON_VCS_REMOTE_BRANCH     \UE804" "     #  not displayed, should be branch icon on a book
set -g ICON_VCS_DETACHED_BRANCH   \U27A6" "     # ➦
set -g ICON_VCS_GIT               \UF00A" "     #  from Octicons
set -g ICON_VCS_HG                \F0DD" "      # Got cut off from Octicons on patching
set -g ICON_VCS_CLEAN             \UF03A        # 
set -g ICON_VCS_PUSH              printf "\UF005 " # bugs out in fish: \UF005 (printf "\UF005")
set -g ICON_VCS_DIRTY             ±             #
set -g ICON_ARROW_UP              \UF03D""      #  ↑
set -g ICON_ARROW_DOWN            \UF03F""      #  ↓
set -g ICON_OK                    \UF03A        # 
set -g ICON_FAIL                  \UF081        # 
set -g ICON_STAR                  \UF02A        # 
set -g ICON_JOBS                  \U2699" "     # ⚙
set -g ICON_VIM                   \UE7C5" "     # 
set -g ICON_BRANCH                \UE725 
set -g ICON_RANGER                \UFB44

end
