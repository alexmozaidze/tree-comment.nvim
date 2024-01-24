<div align="center">

# tree-comment.nvim

![Demo](/demo.png)

Improved integration of Tree-sitter [comment](https://github.com/stsewd/tree-sitter-comment) parser. Define desired keyword highlights using a simple table. No need to tinker with query files!

</div>

> [!IMPORTANT]\
> This plugin is WIP. Expect breaking changes and lots of rebasing that will break your config.

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
      warning = { "WARNING", "WARN", "SAFETY", "HACK", "XXX" },
      error = { "FIXME", "FIX", "BUG", "ERROR" },
   },
}
```

### Dynamically updating global config

It is safe to re-run `setup` multiple times in order to change the global config on the fly.

Here's an example that replaces `todo` keywords and disables `error` keywords, just copy-paste it as a command and don't forget to re-open the buffer:
```vim
:lua require "tree-comment".setup { keywords = { todo = { "DOIT", "JUSTDOIT" }, error = {} } }
```

### Integration with [folke/todo-comments.nvim](https://github.com/folke/todo-comments.nvim)

WIP. Will be available as a separate plugin that will integrate both of these together in a single interface.
