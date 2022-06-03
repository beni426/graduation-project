server '35.79.68.32', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/home/beni/.ssh/id_rsa'
