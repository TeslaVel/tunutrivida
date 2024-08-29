# max_threads_count = ENV.fetch("RAILS_MAX_THREADS") { 1 }
# min_threads_count = ENV.fetch("RAILS_MIN_THREADS") { max_threads_count }
# threads min_threads_count, max_threads_count

# port ENV.fetch('PORT') { 3000 }

# workers 1

# # app_dir = File.expand_path("../..", __FILE__)
# app_dir = "/www/tunutrivida"  # Ruta a tu aplicación de Rails
# shared_dir = "#{app_dir}/shared"

# rails_env = ENV['RAILS_ENV'] || "production"
# environment rails_env

# bind "unix://#{shared_dir}/sockets/puma.sock"

# stdout_redirect "#{shared_dir}/log/puma.stdout.log", "#{shared_dir}/log/puma.stderr.log", true

# pidfile "#{shared_dir}/pids/puma.pid"
# state_path "#{shared_dir}/pids/puma.state"
# activate_control_app