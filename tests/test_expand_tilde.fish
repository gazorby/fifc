set curr_home $HOME
set -gx HOME /home/test-user

set actual (_fifc_expand_tilde '~/downloads')
@test "expand current user tilde path" "$actual" = /home/test-user/downloads

set actual (_fifc_expand_tilde '~otheruser/downloads')
@test "do not expand other user tilde path" "$actual" = '~otheruser/downloads'

set -gx HOME $curr_home
