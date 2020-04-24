local BasePlugin = require "kong.plugins.base_plugin"
local access = require "kong.plugins.lauthz.access"

local LauthzHandler = BasePlugin:extend()

LauthzHandler.PRIORITY = 100

function LauthzHandler:new()
  LauthzHandler.super.new(self, "lauthz")
end

function LauthzHandler:access(conf)
  LauthzHandler.super.access(self)
  access.execute(conf)
end

return LauthzHandler