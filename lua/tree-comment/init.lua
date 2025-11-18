local _local_1_ = require("tree-comment/_query-handling")
local apply_queries = _local_1_["apply-queries"]
local _local_2_ = require("tree-comment/_config")
local default_opts = _local_2_["default-opts"]
local folkify_keywords = _local_2_["folkify-keywords"]
local unfolkify_keywords = _local_2_["unfolkify-keywords"]
local saved_keywords = default_opts
local M = {}
M.folkify_keywords = folkify_keywords
M.unfolkify_keywords = unfolkify_keywords
M.update_keywords = function(keywords)
  if (nil == keywords) then
    _G.error("Missing argument keywords on fnl/tree-comment/init.fnl:12", 2)
  else
  end
  saved_keywords = vim.tbl_deep_extend("force", default_opts.keywords, keywords)
  return apply_queries(saved_keywords)
end
M.get_keywords = function()
  return saved_keywords
end
M.setup = function(_3fopts)
  local opts = (_3fopts or {})
  local opts0 = vim.tbl_deep_extend("force", default_opts, opts)
  return M.update_keywords(opts0.keywords)
end
return M
