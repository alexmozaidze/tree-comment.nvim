[tree-sitter-comment]: https://github.com/stsewd/tree-sitter-comment
[todo-comments.nvim]: https://github.com/folke/todo-comments.nvim

<div align="center">

# tree-comment.nvim

![Demo](/demo.png)

Integration with [tree-sitter-comment] parser. Define desired keyword highlights using a simple table, without ever touching any query files!

</div>

## Installation

Using Lazy:
```lua
{
   "alexmozaidze/tree-comment.nvim",
   dependencies = "nvim-treesitter/nvim-treesitter",
   opts = {},
}
```

### Default options

```lua
{
   -- `@comment.*` highlight groups get generated from these keywords.
   -- If you add a new keyword group like: `test = { "TEST", "SUCCESS", "FAILURE" }`,
   -- then you'll need to add highlighting to `@comment.test`.
   keywords = {
      todo = { "TODO", "WIP" },
      note = { "NOTE", "INFO", "DOCS", "PERF", "TEST" },
      warning = { "WARN", "WARNING", "SAFETY", "HACK", "XXX" },
      error = { "FIX", "FIXME", "BUG", "ERROR" },
   },
}
```

### Dynamically configure keywords

Here's an example that replaces `todo` keywords and disables `error` keywords, just copy-paste it as a command and don't forget to re-open the buffer:
```vim
:lua require "tree-comment".update_keywords { todo = { "DOIT", "JUSTDOIT" }, error = {} }
```

### Integration with [todo-comments.nvim]

Below I've made a snippet you can use to integrate into [todo-comments.nvim] yourself. Just keep in mind that comments like `-- TODO(alexmozaidze): things` won't get recognized by [todo-comments.nvim] by default (See [folke/todo-comments.nvim#10](https://github.com/folke/todo-comments.nvim/issues/10)).

```lua
-- Plugins setup
{
   {
      "alexmozaidze/tree-comment.nvim",
      dependencies = "nvim-treesitter/nvim-treesitter",
      opts = {
         keywords = {
            caution = { "CAUTION", "STOP" },
         },
      },
   },
   {
      "folke/todo-comments.nvim",
      dependencies = { "nvim-lua/plenary.nvim", "alexmozaidze/tree-comment.nvim" },
      config = function()
         local tree_comment = require "tree-comment"
         local folkified_keywords, colors = tree_comment.folkify_keywords(tree_comment.get_keywords())

         folkified_keywords.CAUTION.icon = "☢" -- Optional. Only for custom groups

         require "todo-comments".setup {
            keywords = folkified_keywords,
            colors = colors,
            highlight = { keyword = "empty", after = "" }, -- Optional. Just to make it look the same as tree-comment's highlighting
         }
      end,
   },
}
```
