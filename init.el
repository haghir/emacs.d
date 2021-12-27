;; Copyright 2016 haghir
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;; ============================================================================
;; Global Settings.
;; ============================================================================

;; .emacs.d
(when load-file-name
  (setq user-emacs-directory
        (file-name-directory load-file-name)))

;; Encording.
(set-default-coding-systems 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-buffer-file-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; Global.
(setq global-hl-line-mode t)
(setq global-linum-mode t)
(setq line-number-mode t)
(setq column-number-mode t)
(setq-default indent-tabs-mode t)
(setq-default tab-width 8)

;; GUI
(when (display-graphic-p)
  ;; Font.
  (create-fontset-from-ascii-font "Source Han Code JP R-12:weight=normal:slant=normal"
                                  nil
                                  "myfonts")
  (set-fontset-font "fontset-myfonts"
                    'unicode
                    "Source Han Code JP R-12:weight=normal:slant=normal"
                    nil
                    'append)
  (add-to-list 'default-frame-alist
               '(font . "fontset-myfonts"))
  ;; Theme
  (load-theme 'manoj-dark t)
  (set-face-background 'default "#1e1e1e")
  (set-face-foreground 'default "#dcdcdc"))

;; Whitespace.
(global-whitespace-mode t)
(set-face-background 'whitespace-tab nil)
(set-face-background 'whitespace-space nil)
(set-face-foreground 'whitespace-line nil)
(set-face-background 'whitespace-line nil)

;; Size.
(when window-system (set-frame-size (selected-frame) 80 25))

;; ============================================================================
;; Individual Settings.
;; ============================================================================

;; mozc
(add-to-list 'load-path (locate-user-emacs-file "vendor/mozc"))
(setq default-input-method "japanese-mozc")
(require 'mozc)

;; gtags (requires GNU Global)
(add-to-list 'load-path (locate-user-emacs-file "vendor/gtags"))
(require 'gtags)

;; pcre2el
(add-to-list 'load-path (locate-user-emacs-file "vendor/pcre2el"))
(require 'pcre2el)

;; visual-regexp
(add-to-list 'load-path (locate-user-emacs-file "vendor/visual-regexp"))
(add-to-list 'load-path (locate-user-emacs-file "vendor/visual-regexp-steroids"))
(require 'visual-regexp-steroids)
(setq vr/engine 'pcre2el)

;; async
(add-to-list 'load-path (locate-user-emacs-file "vendor/async"))
(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

;; helm
(add-to-list 'load-path (locate-user-emacs-file "vendor/helm"))
(require 'helm-config)
(helm-mode 1)

;; yasnippet
(add-to-list 'load-path (locate-user-emacs-file "vendor/yasnippet"))
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs (locate-user-emacs-file
                                "snippets"))
(add-to-list 'yas-snippet-dirs (locate-user-emacs-file
                                "vendor/yasmate/snippets"))
(add-to-list 'yas-snippet-dirs (locate-user-emacs-file
                                "vendor/yasnippet-snippets/snippets"))
(yas-global-mode 1)

;; Shell script
(setq sh-basic-offset 8)
(setq sh-indentation 8)

;; SQL
(add-hook 'sql-mode-hook (lambda ()
                           (setq indent-tabs-mode nil)
                           (setq tab-width 4)
                           (setq sql-indent-offset 4)))

;; Lisp Mode
(add-hook 'emacs-lisp-mode-hook (lambda ()
                                  (setq indent-tabs-mode nil)))

;; C Mode
(add-hook 'c-mode-common-hook (lambda ()
                                (setq indent-tabs-mode t)
                                (setq tab-width 8)
                                (setq c-basic-offset 8)))
(add-to-list 'auto-mode-alist '("\\.tc\\'" . c-mode))

;; Bison Mode
(add-to-list 'load-path (locate-user-emacs-file  "vendor/bison-mode"))
(autoload 'bison-mode "bison-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.y\\'" . bison-mode))
(add-to-list 'auto-mode-alist '("\\.l\\'" . bison-mode))
(add-hook 'bison-mode-hook (lambda ()
                             (setq indent-tabs-mode t)
                             (setq bison-basic-offset 8)
                             (setq tab-width 8)))
(setq imenu-create-index-function
      (lambda ()
        (let ((end))
          (beginning-of-buffer)
          (re-search-forward "^%%")
          (forward-line 1)
          (setq end (save-excursion (re-search-forward "^%%") (point)))
          (loop while (re-search-forward "^\\([a-z].*?\\)\\s-*\n?\\s-*:" end t)
                collect (cons (match-string 1) (point))))))

;; Haskell Mode
(add-to-list 'load-path (locate-user-emacs-file "vendor/haskell-mode"))
(autoload 'haskell-mode "haskell-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.hs\\'" . haskell-mode))

;; Scala Mode
(add-to-list 'load-path (locate-user-emacs-file "vendor/scala-mode"))
(autoload 'scala-mode "scala-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.scala\\'" . scala-mode))

;; Rust Mode
(add-to-list 'load-path (locate-user-emacs-file "vendor/rust-mode"))
(autoload 'rust-mode "rust-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))
(add-hook 'rust-mode-hook (lambda ()
                            (setq indent-tabs-mode nil)
                            (setq tab-width 4)
                            (setq rust-indent-offset 4)))

;; Python Mode
(add-hook 'python-mode-hook (lambda ()
                              (setq indent-tabs-mode nil)
                              (setq tab-width 4)
                              (setq python-indent-offset 4)))

;; Perl Mode
(defalias 'perl-mode 'cperl-mode)
(add-to-list 'auto-mode-alist '("\\.yp\\'" . cperl-mode))
(add-hook 'cperl-mode-hook (lambda ()
                             (setq indent-tabs-mode t)
                             (setq tab-width 8)
                             (setq cperl-indent-level 8)))

;; JS2 Mode
(add-to-list 'load-path (locate-user-emacs-file "vendor/js2-mode"))
(autoload 'js2-mode "js2-mode" nil t)
(autoload 'js2-jsx-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js2-jsx-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.cfc\\'" . js2-mode))
(add-hook 'js2-mode-hook (lambda ()
                           (setq indent-tabs-mode nil)
                           (setq js2-basic-offset 4)
                           (setq tab-width 4)))
(add-hook 'js2-jsx-mode-hook (lambda ()
                               (setq indent-tabs-mode nil)
                               (setq js2-basic-offset 4)
                               (setq tab-width 4)))

;; TypeScript Mode
(add-to-list 'load-path (locate-user-emacs-file "vendor/typescript-mode"))
(autoload 'typescript-mode "typescript-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-hook 'typescript-mode-hook (lambda ()
                                  (setq indent-tabs-mode nil)
                                  (setq typescript-indent-level 4)
                                  (setq tab-width 4)))

;; Web Mode
(add-to-list 'load-path (locate-user-emacs-file "vendor/web-mode"))
(autoload 'web-mode "web-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.cfm\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
(add-hook 'web-mode-hook (lambda ()
                           (setq indent-tabs-mode nil)
                           (setq web-mode-markup-indent-offset 2)
                           (setq web-mode-css-indent-offset 2)
                           (setq web-mode-code-indent-offset 2)
                           (setq tab-width 2)))

;; Markdown Mode
(add-to-list 'load-path (locate-user-emacs-file "vendor/markdown-mode"))
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . gfm-mode))
(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))
(add-hook 'markdown-mode-hook (lambda ()
                                (setq indent-tabs-mode nil)
                                (setq tab-width 4)
                                (setq markdown-list-indent-width 4)
                                (setq indent-line-function 'insert-tab)))
;; CSharp Mode
(add-to-list 'load-path (locate-user-emacs-file "vendor/csharp-mode"))
(autoload 'csharp-mode "csharp-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.cs\\'" . csharp-mode))
(add-hook 'csharp-mode-hook (lambda ()
                              (setq indent-tabs-mode nil)
                              (setq tab-width 4)
                              (setq c-basic-offset 4)))

;; Text Mode
(add-hook 'text-mode-hook (lambda ()
                            (setq indent-tabs-mode nil)
                            (setq tab-width 3)))

;; ============================================================================
;; Key bind
;; ============================================================================

;; General
(global-set-key (kbd "C-`") 'toggle-input-method)
(global-set-key (kbd "M-`") 'toggle-input-method)
(global-set-key (kbd "C-t") 'toggle-truncate-lines)
(global-set-key (kbd "C-M-!") 'eshell)

;; Window
(global-set-key (kbd "<C-up>") 'shrink-window)
(global-set-key (kbd "<C-down>") 'enlarge-window)
(global-set-key (kbd "<C-left>") 'shrink-window-horizontally)
(global-set-key (kbd "<C-right>") 'enlarge-window-horizontally)

;; Search
(global-set-key (kbd "C-c s") 'replace-string)
(global-set-key (kbd "C-c r") 'vr/replace)
(global-set-key (kbd "C-c q") 'vr/query-replace)
(global-set-key (kbd "C-M-r") 'vr/isearch-backward)
(global-set-key (kbd "C-M-s") 'vr/isearch-forward)

;; gtags
(global-set-key (kbd "M-t") 'gtags-find-tag)
(global-set-key (kbd "M-r") 'gtags-find-rtag)
(global-set-key (kbd "M-s") 'gtags-find-symbol)
(global-set-key (kbd "M-p") 'gtags-pop-stack)
