(local M {})

;; The following keywords should be colored in order.
;;
;; Todo:
;; - TODO
;; - WIP
;;
;; Note:
;; - NOTE
;; - INFO
;; - DOCS
;; - PERF
;; - TEST
;;
;; Warning:
;; - WARNING
;; - WARN
;; - SAFETY
;; - HACK
;; - XXX
;;
;; Error:
;; - FIXME
;; - FIX
;; - BUG
;; - ERROR
(set M.default-opts
     {:keywords {:todo    [:TODO :WIP]
                 :note    [:NOTE :INFO :DOCS :PERF :TEST]
                 :warning [:WARN :WARNING :SAFETY :HACK :XXX]
                 :error   [:FIX :FIXME :BUG :ERROR]}})

(λ M.folkify-keywords [keywords]
  "Transforms keywords to be compatible with folke's todo-comments.nvim.
Also, returns `colors` as its second argument

{ todo = { \"TODO\", \"WIP\" } } -> { TODO = { alt = { \"WIP\" }, color = \"todo\" } }"
  (let [folkified-keywords (collect [group keywords (pairs (vim.deepcopy keywords))]
                             (let [folkified-key (table.remove keywords 1)
                                   folkified-keywords {:alt keywords :color group}]
                               (values folkified-key folkified-keywords)))
        folky-colors (collect [group _ (pairs keywords)]
                       (values group [(.. "@comment." group)]))]
    (values folkified-keywords folky-colors)))

(λ M.unfolkify-keywords [folky-tbl]
  "Transforms keywords from folke's todo-comments.nvim to be compatible with tree-comment.nvim.

{ TODO = { alt = { \"WIP\" }, color = \"todo\" } } -> { todo = { \"TODO\", \"WIP\" } }"
  (collect [keyword {:alt keywords :color group} (pairs (vim.deepcopy folky-tbl))]
    (do
      (table.insert keywords keyword)
      (values group keywords))))

M
