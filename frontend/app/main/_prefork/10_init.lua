if config.fork == nil then
  config.fork = {}
end

if config.fork.pre == nil then
  config.fork.pre = 2
end

if config.fork.min == nil then
  config.fork.min = 4
end

if config.fork.max == nil then
  config.fork.max = 128
end

if config.fork.delay == nil then
  config.fork.delay = 0.125
end

if config.fork.error_delay == nil then
  config.fork.error_delay = 2
end

if config.fork.exit_delay == nil then
  config.fork.exit_delay = 2
end

if config.fork.idle_timeout == nil then
  config.fork.idle_timeout = 900
end

if config.port == nil then
  config.port = 8080
end

if config.localhost == nil then
  config.localhost = true
end

local listen_options = {
  pre_fork              = config.fork.pre,
  min_fork              = config.fork.min,
  max_fork              = config.fork.max,
  fork_delay            = config.fork.delay,
  fork_error_delay      = config.fork.error_delay,
  exit_delay            = config.fork.exit_delay,
  idle_timeout          = config.fork.idle_timeout,
  memory_limit          = config.fork.memory_limit,
  min_requests_per_fork = config.fork.min_requests,
  max_requests_per_fork = config.fork.max_requests,
  http_options          = config.http_options
}

if config.ipv6 then
  listen_options[#listen_options+1] = { proto = "tcp6", port = config.port, localhost = config.localhost }
end
if config.ipv6 ~= "only" then
  listen_options[#listen_options+1] = { proto = "tcp4", port = config.port, localhost = config.localhost }
end

listen(listen_options)

listen{
  {
    proto = "interval",
    name  = "send_pending_notifications",
    delay = 5,
    handler = function() 
      Event:send_pending_notifications()
    end
  },
  min_fork = 1,
  max_fork = 1
}

execute.inner()

