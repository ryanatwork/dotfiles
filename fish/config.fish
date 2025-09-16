set -g fish_greeting ''

set -x SECFILES $HOME/.secret

# Import secret config
[ -f $SECFILES/fish/config.fish ]; and . $SECFILES/fish/config.fish

set -x EDITOR (which vim)
set -x NODE_PATH /usr/local/lib/node_modules
set -x PATH /usr/local/bin $PATH
set -x PATH /usr/local/sbin $PATH
set -x PATH /usr/local/share/npm/bin $PATH
set -x PATH $HOME/.rbenv/bin $PATH
set -x PATH $HOME/.rbenv/shims $PATH
set -x PATH $HOME/bin $PATH
set -x RUBYGEMS_EC2_DB1 ec2-54-245-133-190.us-west-2.compute.amazonaws.com
set -x RUBYGEMS_EC2_LB1 54.245.255.174
set -x JAVA_HOME (/usr/libexec/java_home)
set -x NVM_DIR $HOME/.nvm

# Needed for building libsalty2 on Apple Silicon chips
set -x LDFLAGS "-L/opt/homebrew/opt/libsodium"
set -x C_INCLUDE_PATH /opt/homebrew/include
set -x CPLUS_INCLUDE_PATH /opt/homebrew/include
set -x LIBRARY_PATH /opt/homebrew/lib

# Elixir Options
set -gx ERL_AFLAGS "-kernel shell_history enabled"
source ~/.asdf/asdf.fish

set -g fish_user_paths "/usr/local/opt/openssl@1.1/bin" $fish_user_paths

#set -x RUBY_CONFIGURE_OPTS "--with-openssl-dir=(brew --prefix openssl@1.1)"
#set -x CFLAGS "-Wno-error=implicit-function-declaration"

# Added by change/development_environment script
set -x WORKDIR /Users/rresella/work
set -x PATH $WORKDIR/development_environment/bin $PATH

kubectl completion fish | source

