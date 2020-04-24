local hrequest = require "http.request"
local kong = kong

local _M = {}

function _M.execute(conf)
  -- get :method, path
  local method = kong.request.get_method()
  local path = kong.request.get_path()
  -- get "X-Request-UserUUID"
  local user_uuid = kong.request.get_headers("X-Request-UserUUID")

  -- send to authz
  kong.log.info("method is: " .. method)
  kong.log.info("path is: " .. path)
  kong.log.info("userUUID is: " .. user_uuid)

  local uri = string.format("http://172.16.0.43:8888/authz?sub=%s&obj=%s&act=%s", user_uuid, path, method)
  local req = hrequest.new_from_uri(uri)
  local headers, stream = req:go()
  if headers:get ":status" ~= "200" then
    kong.response.exit(403, "forbidden")
  end

  local body, err = stream:get_body_as_string()
  if not body then
    kong.log.info("body: " .. body)
  end
end

return _M
