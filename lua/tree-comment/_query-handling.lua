local M = {}
M.template = "\n((tag\n  (name) %(hl)s @nospell\n  (\"(\" @punctuation.bracket\n    (user) @constant\n    \")\" @punctuation.bracket)?\n  \":\" @punctuation.delimiter)\n  (#any-of? %(hl)s %(keywords)s))\n\n(\"text\" %(hl)s @nospell\n  (#any-of? %(hl)s %(keywords)s))\n"
M["other-queries"] = "\n(\"text\" @number\n  (#lua-match? @number \"^#[0-9]+$\"))\n\n((uri) @text.uri @nospell)\n"
M["string-format"] = function(fmt, sub_args)
  if (nil == sub_args) then
    _G.error("Missing argument sub-args on fnl/tree-comment/_query-handling.fnl:24", 2)
  else
  end
  if (nil == fmt) then
    _G.error("Missing argument fmt on fnl/tree-comment/_query-handling.fnl:24", 2)
  else
  end
  assert(("string" == type(fmt)))
  assert(("table" == type(sub_args)))
  local pattern = "%%%((%a%w*)%)([-0-9%.]*[cdeEfgGiouxXsq])"
  local interpolator
  local function _3_(named_replace_arg, format_modifier)
    if (nil == format_modifier) then
      _G.error("Missing argument format-modifier on fnl/tree-comment/_query-handling.fnl:29", 2)
    else
    end
    if (nil == named_replace_arg) then
      _G.error("Missing argument named-replace-arg on fnl/tree-comment/_query-handling.fnl:29", 2)
    else
    end
    if sub_args[named_replace_arg] then
      return string.format(("%" .. format_modifier), sub_args[named_replace_arg])
    else
      return ("%(" .. named_replace_arg .. ")" .. format_modifier)
    end
  end
  interpolator = _3_
  return string.gsub(fmt, pattern, interpolator)
end
M["keyword->query"] = function(hl, keywords)
  if (nil == keywords) then
    _G.error("Missing argument keywords on fnl/tree-comment/_query-handling.fnl:36", 2)
  else
  end
  if (nil == hl) then
    _G.error("Missing argument hl on fnl/tree-comment/_query-handling.fnl:36", 2)
  else
  end
  assert(("string" == type(hl)))
  assert(("table" == type(keywords)))
  local hl0 = ("@comment." .. hl)
  local keywords0
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for _, name in ipairs(keywords) do
      local val_28_ = ("\"" .. name .. "\"")
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    keywords0 = tbl_26_
  end
  local keywords1 = table.concat(keywords0, " ")
  return M["string-format"](M.template, {hl = hl0, keywords = keywords1})
end
M["keywords->query"] = function(keywords)
  if (nil == keywords) then
    _G.error("Missing argument keywords on fnl/tree-comment/_query-handling.fnl:45", 2)
  else
  end
  local keywords0
  do
    local tbl_26_ = {}
    local i_27_ = 0
    for hl, keyword in pairs(keywords) do
      local val_28_ = M["keyword->query"](hl, keyword)
      if (nil ~= val_28_) then
        i_27_ = (i_27_ + 1)
        tbl_26_[i_27_] = val_28_
      else
      end
    end
    keywords0 = tbl_26_
  end
  return table.concat(keywords0, "\n")
end
M["apply-queries"] = function(keywords)
  if (nil == keywords) then
    _G.error("Missing argument keywords on fnl/tree-comment/_query-handling.fnl:51", 2)
  else
  end
  local hl_query = (M["keywords->query"](keywords) .. M["other-queries"])
  return vim.treesitter.query.set("comment", "highlights", hl_query)
end
return M
