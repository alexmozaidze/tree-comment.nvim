(local {: apply-queries} (require :tree-comment/_query-handling))
(local {: default-opts : folkify-keywords : unfolkify-keywords} (require :tree-comment/_config))

;; For keeping track of in-use keywords (it would be really expensive to parse it back from query files)
(var saved-keywords default-opts)

(local M {})

(set M.folkify_keywords folkify-keywords)
(set M.unfolkify_keywords unfolkify-keywords)

(λ M.update_keywords [keywords]
  "Updates the keywords you want to use."
  (set saved-keywords (vim.tbl_deep_extend :force default-opts.keywords keywords))
  (apply-queries saved-keywords))

(λ M.get_keywords []
  "Returns a table of currently used keywords. You shouldn't directly modify this table."
  saved-keywords)

(λ M.setup [?opts]
  (let [opts (or ?opts {})
        opts (vim.tbl_deep_extend :force default-opts opts)]
    (M.update_keywords opts.keywords)))

M
