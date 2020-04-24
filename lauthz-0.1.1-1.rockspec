package = "lauthz"

version = "0.1.1-1"

-- The version '0.1.1' is the source code version, the trailing '1' is the version of this rockspec.
-- whenever the source version changes, the rockspec should be reset to 1. The rockspec version is only
-- updated (incremented) when this file changes, but the source remains the same.

supported_platforms = {"linux", "macosx"}

source = {
  url = "git://github.com/kuafou/kong-authz",
}

description = {
  summary = "A Kong plugin that allows for an extra HTTP POST request before proxying the original.",
  license = "MIT"
}

dependencies = {
  "http"
}

build = {
  type = "builtin",
  modules = {
    ["kong.plugins.lauthz.access"] = "src/access.lua",
    ["kong.plugins.lauthz.handler"] = "src/handler.lua",
    ["kong.plugins.lauthz.schema"] = "src/schema.lua",
  }
}
