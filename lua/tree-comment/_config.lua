local M = {}
M["default-opts"] = {keywords = {todo = {"TODO", "WIP"}, note = {"NOTE", "INFO", "DOCS", "PERF", "TEST"}, warning = {"WARN", "WARNING", "SAFETY", "HACK", "XXX"}, error = {"FIX", "FIXME", "BUG", "ERROR"}}}
M["folkify-keywords"] = function(keywords)
  if (nil == keywords) then
    _G.error("Missing argument keywords on fnl/tree-comment/_config.fnl:34", 2)
  else
  end
  local folkified_keywords
  do
    local tbl_21_ = {}
    for group, keywords0 in pairs(vim.deepcopy(keywords)) do
      local k_22_, v_23_
      do
        local folkified_key = table.remove(keywords0, 1)
        local folkified_keywords0 = {alt = keywords0, color = group}
        k_22_, v_23_ = folkified_key, folkified_keywords0
      end
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    folkified_keywords = tbl_21_
  end
  local folky_colors
  do
    local tbl_21_ = {}
    for group, _ in pairs(keywords) do
      local k_22_, v_23_ = group, {("@comment." .. group)}
      if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
        tbl_21_[k_22_] = v_23_
      else
      end
    end
    folky_colors = tbl_21_
  end
  return folkified_keywords, folky_colors
end
M["unfolkify-keywords"] = function(folky_tbl)
  if (nil == folky_tbl) then
    _G.error("Missing argument folky-tbl on fnl/tree-comment/_config.fnl:47", 2)
  else
  end
  local tbl_21_ = {}
  for keyword, _5_ in pairs(vim.deepcopy(folky_tbl)) do
    local keywords = _5_.alt
    local group = _5_.color
    local k_22_, v_23_
    do
      table.insert(keywords, keyword)
      k_22_, v_23_ = group, keywords
    end
    if ((k_22_ ~= nil) and (v_23_ ~= nil)) then
      tbl_21_[k_22_] = v_23_
    else
    end
  end
  return tbl_21_
end
return M
