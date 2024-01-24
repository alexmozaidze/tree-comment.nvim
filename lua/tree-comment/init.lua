local template = "\n((tag\n  (name) %(hl)s @nospell\n  (\"(\" @punctuation.bracket\n    (user) @constant\n    \")\" @punctuation.bracket)?\n  \":\" @punctuation.delimiter)\n  (#any-of? %(hl)s %(keywords)s))\n\n(\"text\" %(hl)s @nospell\n  (#any-of? %(hl)s %(keywords)s))\n"
local other_queries = "\n(\"text\" @number\n  (#lua-match? @number \"^#[0-9]+$\"))\n\n((uri) @text.uri @nospell)\n"
local function string_format(fmt, sub_args)
  _G.assert((nil ~= sub_args), "Missing argument sub-args on fnl/tree-comment/init.fnl:22")
  _G.assert((nil ~= fmt), "Missing argument fmt on fnl/tree-comment/init.fnl:22")
  assert(("string" == type(fmt)))
  assert(("table" == type(sub_args)))
  local pattern = "%%%((%a%w*)%)([-0-9%.]*[cdeEfgGiouxXsq])"
  local interpolator
  local function _1_(named_replace_arg, format_modifier)
    _G.assert((nil ~= format_modifier), "Missing argument format-modifier on fnl/tree-comment/init.fnl:27")
    _G.assert((nil ~= named_replace_arg), "Missing argument named-replace-arg on fnl/tree-comment/init.fnl:27")
    if sub_args[named_replace_arg] then
      return string.format(("%" .. format_modifier), sub_args[named_replace_arg])
    else
      return ("%(" .. named_replace_arg .. ")" .. format_modifier)
    end
  end
  interpolator = _1_
  return string.gsub(fmt, pattern, interpolator)
end
local function keyword__3equery(hl, keywords)
  _G.assert((nil ~= keywords), "Missing argument keywords on fnl/tree-comment/init.fnl:34")
  _G.assert((nil ~= hl), "Missing argument hl on fnl/tree-comment/init.fnl:34")
  assert(("string" == type(hl)))
  assert(("table" == type(keywords)))
  local hl0 = ("@comment." .. hl)
  local keywords0
  do
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for _, name in ipairs(keywords) do
      local val_19_auto = ("\"" .. name .. "\"")
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    keywords0 = tbl_17_auto
  end
  local keywords1 = table.concat(keywords0, " ")
  return string_format(template, {hl = hl0, keywords = keywords1})
end
local function keywords__3equery(keywords)
  _G.assert((nil ~= keywords), "Missing argument keywords on fnl/tree-comment/init.fnl:43")
  local keywords0
  do
    local tbl_17_auto = {}
    local i_18_auto = #tbl_17_auto
    for hl, keyword in pairs(keywords) do
      local val_19_auto = keyword__3equery(hl, keyword)
      if (nil ~= val_19_auto) then
        i_18_auto = (i_18_auto + 1)
        do end (tbl_17_auto)[i_18_auto] = val_19_auto
      else
      end
    end
    keywords0 = tbl_17_auto
  end
  return table.concat(keywords0, "\n")
end
local M = {}
M.setup = function(_3fopts)
  local _let_5_ = require("tree-comment/_config")
  local default_opts = _let_5_["default-opts"]
  local opts = (_3fopts or {})
  local opts0 = vim.tbl_deep_extend("force", default_opts, opts)
  local hl_query = (keywords__3equery(opts0.keywords) .. other_queries)
  return vim.treesitter.query.set("comment", "highlights", hl_query)
end
return M
