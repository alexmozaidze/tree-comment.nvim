[fennel-style-guide]: https://fennel-lang.org/style
[discussions]: https://github.com/alexmozaidze/tree-comment.nvim/discussions

# Contributing

## Building

In order to test your changes, you simply run `make`; it compiles Fennel source code from `fnl/` into `lua/`. Then, you simply import your plugin using your plugin manager of choice, and it will Just Work&trade;

> [!NOTE]\
> You don't need to install Fennel, it's already [included](deps/).

Here's an example of how to load your plugin instance locally using Lazy:
```lua
require "lazy".setup {
   {
      "alexmozaidze/tree-comment.nvim",
      dir = "path/to/your/tree-comment.nvim", -- Change this to path to your plugin
   },

   -- other plugins...
}
```

## Style

Follow the [Fennel style guide][fennel-style-guide], but you can diverge when you think it makes sense.

### Use meaningful names

Avoid placeholder names, such as:
- foo, bar, baz
- x, y, z
- utils
- thingie
- etc.

### Functions

Use `lambda` or `λ` instead of `fn`.

## Modules

### Naming

```
public-module.fnl
_private-module.fnl
```

### Structure

Structure all modules (including macro modules) in the following manner:
```fnl
;;; Optional module description.
;;; Mind the 3 semicolons.

;; ╭──────────────────────────────────────────────────────────╮
;; │                         Imports                          │
;; ╰──────────────────────────────────────────────────────────╯

;; import macros

;; import modules

;; ╭──────────────────────────────────────────────────────────╮
;; │                          Locals                          │
;; ╰──────────────────────────────────────────────────────────╯

;; local macros

;; local variables/functions

;; ╭──────────────────────────────────────────────────────────╮
;; │                         Exports                          │
;; ╰──────────────────────────────────────────────────────────╯

;; literal return value (table, array, string, etc.)

;; ╭────╮
;; │ OR │
;; ╰────╯

(local M {})

;; define module properties/methods

M
```

Dummy example:
```fnl
(local {: mooify} (require :cow))

(lambda string->cow [input]
  (assert (= (type input) :string))
  (mooify input))

(local M {})

(set M.string_to_cow string->cow)

(lambda M.moo []
  (print "Moo!"))

M
```

## Most important part...

**Don't be afraid to ask!**

You can always ask about anything in [discussions][discussions], propose a change before starting to work on it, or just to get help.

Thanks for reading, and happy coding!
