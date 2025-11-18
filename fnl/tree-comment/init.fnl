(local template "
((tag
  (name) %(hl)s @nospell
  (\"(\" @punctuation.bracket
    (user) @constant
    \")\" @punctuation.bracket)?
  \":\" @punctuation.delimiter)
  (#any-of? %(hl)s %(keywords)s))

(\"text\" %(hl)s @nospell
  (#any-of? %(hl)s %(keywords)s))
")

(local other-queries "
(\"text\" @number
  (#lua-match? @number \"^#[0-9]+$\"))

((uri) @text.uri @nospell)
")

;; TODO: Add checks for too many and too few sub-args
(λ string-format [fmt sub-args]
  "Safely interpolates a string in the format"
  (assert (= :string (type fmt)))
  (assert (= :table (type sub-args)))
  (let [pattern "%%%((%a%w*)%)([-0-9%.]*[cdeEfgGiouxXsq])"
        interpolator (λ [named-replace-arg format-modifier]
                       (if (. sub-args named-replace-arg)
                           (string.format (.. "%" format-modifier)
                                          (. sub-args named-replace-arg))
                           (.. "%(" named-replace-arg ")" format-modifier)))]
    (string.gsub fmt pattern interpolator)))

(λ keyword->query [hl keywords]
  "Convert a keyword into a query."
  (assert (= :string (type hl)))
  (assert (= :table (type keywords)))
  (let [hl (.. "@comment." hl)
        keywords (icollect [_ name (ipairs keywords)] (.. "\"" name "\""))
        keywords (table.concat keywords " ")]
    (string-format template {: hl : keywords})))

(λ keywords->query [keywords]
  "Convert an array of keywords into a query."
  (let [keywords (icollect [hl keyword (pairs keywords)]
                   (keyword->query hl keyword))]
    (table.concat keywords "\n")))

(local M {})

(λ M.setup [?opts]
  (let [{: default-opts} (require :tree-comment/_config)
        opts (or ?opts {})
        opts (vim.tbl_deep_extend :force default-opts opts)
        hl-query (.. (keywords->query opts.keywords) other-queries)]
    (vim.treesitter.query.set :comment :highlights hl-query)))

M
