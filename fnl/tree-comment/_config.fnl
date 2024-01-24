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
                 :warning [:WARNING :WARN :SAFETY :HACK :XXX]
                 :error   [:FIXME :FIX :BUG :ERROR]}})

M
