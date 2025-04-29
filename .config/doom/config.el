;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/ORGMODE/")

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; Changes cursor depending on mode
(unless (display-graphic-p)
  (require 'evil-terminal-cursor-changer)
  (evil-terminal-cursor-changer-activate) ; or (etcc-on)
  )

;; Set transparency
(add-to-list 'default-frame-alist '(alpha-background . 90)) ;; 90% opacity
(set-face-attribute 'default nil :background "unspecified-bg") ;; Remove background color

;; SuperCollider
(add-to-list 'load-path "~/.local/share/SuperCollider/downloaded-quarks/scel/el")
(require 'sclang)
(require 'w3m)

(after! evil
  (define-key evil-insert-state-map (kbd "ESC") 'evil-escape))

;; Scrolloff
(setq! scroll-margin 7)

;; Auto-format on save

;; Hide some annoying warnings
(require 'warnings)
(add-to-list 'warning-suppress-types '(yasnippet backquote-change))

(map! :leader
      :prefix "f"
      :desc "Find in notes" "n" #'+default/find-in-notes)

(map! :leader
      :desc "Save current buffer" "j" #'save-buffer)

(defun flex/find-in-bin ()
  (interactive)
  (let ((default-directory "~/.local/bin/"))
    (call-interactively #'find-file)))

(map! :leader
      :prefix "f"
      :desc "Find in ~/.local/bin/" "b" #'flex/find-in-bin)

;; Completion
;; (use-package! lsp-bridge
;;   :config
;;   (global-lsp-bridge-mode))
;;

;; unbind some keys
(map! "C-l" nil
      "C-j" nil
      "C-k" nil
      "C-h" nil)

;; (use-package! lsp-bridge
;;   :config
;;   (global-lsp-bridge-mode))

;; Accept completion from copilot and fallback to company
(use-package! company
  :bind (:map company-active-map
              ("C-l" . company-complete)))

(use-package! copilot
  :hook ((js-mode . copilot-mode)
         (emacs-lisp-mode . copilot-mode)
         (typescript-mode . copilot-mode))
  :bind (:map copilot-completion-map
              ("C-S-l" . copilot-accept-completion)
              ("C-S-TAB" . copilot-accept-completion-by-word)
              ("C-S-j" . copilot-next-completion)
              ("C-S-k" . copilot-previous-completion))

  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(closure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

(defun insert-time-stamp ()
  (interactive)
  (insert (format-time-string "[%Y-%m-%d %H:%M] ")))

(map! :leader
      :desc "Insert time stamp" "i t" #'insert-time-stamp)

(use-package! titlecase)

(map! :leader
      :desc "Titlecase line" "t c" 'titlecase-line)

(use-package! copilot-chat)

(defun clean-whitespace ()
  "Delete trailing whitespace, and replace repeated blank lines to just 1.
Only space and tab is considered whitespace here.
Works on whole buffer or selection, respects `narrow-to-region'."
  (interactive)
  (let (xbegin xend)
    (if (region-active-p)
        (setq xbegin (region-beginning) xend (region-end))
      (setq xbegin (point-min) xend (point-max)))
    (save-excursion
      (save-restriction
        (narrow-to-region xbegin xend)
        (goto-char (point-min))
        (while (re-search-forward "[ \t]+\n" nil :move) (replace-match "\n"))
        (goto-char (point-min))
        (while (re-search-forward "\n\n\n+" nil :move) (replace-match "\n\n"))
        (goto-char (point-max))
        (while (eq (char-before) 32) (delete-char -1)))))
  (message "%s done" real-this-command))

(add-hook 'before-save-hook 'clean-whitespace)

;; Global word-wrapping
(global-visual-line-mode t)

;;   ___  ____   ____
;;  / _ \|  _ \ / ___|
;; | | | | |_) | |  _
;; | |_| |  _ <| |_| |
;;  \___/|_| \_\\____|
;;  org-mode settings

;; F as lowest priority
(setq! org-priority-highest ?A)
(setq! org-priority-default ?C)
(setq! org-priority-lowest ?F)

;; ;; Starts org-mode folded
;; (setq! org-hide-block-startup 1)
(setq org-startup-folded 'fold)

;; Enters timestamp when a task is marked as done
(setq! org-log-done 'time)

;; Hide items that are scheduled in the future from the agenda
(setq! org-agenda-todo-ignore-scheduled 'future)
(setq! org-agenda-tags-todo-honor-ignore-options t)

;; Define keybinding for custom agenda command
(map! :leader
      :prefix ("o a" . "Org Agenda")
      :desc "TODO Agenda" "t" #'(lambda () (interactive) (org-agenda nil "t")))

;; Bind `SPC SPC` to `+vertico/switch-workspace-buffer`
(map! :leader
      :desc "Switch workspace buffer" "SPC" #'+vertico/switch-workspace-buffer)

(setq org-time-stamp-rounding-minutes '(0 1)) ;; Always include time
