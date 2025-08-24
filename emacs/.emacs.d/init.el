;;; -*- lexical-binding: t -*-


;;;;;;;;;;;;;;;;;;;;;
;; Startup Options ;;
;;;;;;;;;;;;;;;;;;;;;

;; temporary hack for Dired on Rocky9.3
;; (defvar enable-dir-local-variables nil)

;; Set the window size for startup
(when window-system (set-frame-size (selected-frame) 155 55))
;; or using these
;; (add-to-list 'default-frame-alist '(height . 50))
;; (add-to-list 'default-frame-alist '(width . 120))

;; Don't display startup screen
(setq inhibit-startup-screen t)

;; Give some breathing room
(set-fringe-mode 15)

;; Change the default font
(set-face-attribute 'default nil :font "Fira Code Retina" :height 120)

;; Don't break symbolic links when saving
;; (setq file-preserve-symlinks-on-save t)


;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Package configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Initialize package system
(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
			 ("org" . "https://orgmode.org/elpa")
			 ("gnu" . "https://elpa.gnu.org/packages/")))
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Setup use-package
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t
      use-package-expand-minimally t)

;; (use-package auto-package-update
;;   :custom
;;   (auto-package-update-interval 7)
;;   (auto-package-update-prompt-before-update t)
;;   (auto-package-update-hide-results t)
;;   :config
;;   (auto-package-update-maybe)
;;   (auto-package-update-at-time "09:00"))

;; Optionally, track command history. This needs to be toggled in each buffer as needed,
;; via `M-x command-log-mode' and `clm/toggle-command-log-buffer'
(use-package command-log-mode)
;;  :hook (after-init . global-command-log-mode))

;; Keep the GPG signing up-to-date
;;(use-package gnu-elpa-keyring-update
;;  :ensure t)

;; NOTE: If you want to move everything out of the ~/.emacs.d folder
;; reliably, set `user-emacs-directory` before loading no-littering!
;(setq user-emacs-directory "~/.cache/emacs")
;; (use-package no-littering)
;; no-littering doesn't set this by default so we must place
;; auto save files in the same path as it uses for sessions
;; (setq auto-save-file-name-transforms
;;      `((".*" ,(no-littering-expand-var-file-name "auto-save/") t)))



;; Build a second brain!
(use-package org-roam
    :ensure t
    :init
    (setq org-roam-v2-ack t)
    :custom
    (org-roam-directory "~/org/roam")
    (org-roam-completion-everywhere t)
    :bind (("C-c n l" . org-roam-buffer-toggle)
	   ("C-c n f" . org-roam-node-find)
	   ("C-c n i" . org-roam-node-insert)
	   :map org-mode-map
	   ("C-M-i"   . completion-at-point))
    :config
    (org-roam-setup))

;; Company mode completions (for now)
(use-package company
  :ensure t
  :hook (after-init . global-company-mode))


;; Spell checking
(setq-default ispell-program-name "aspell")
(use-package flyspell
  :config
  (add-hook 'text-mode-hook 'flyspell-mode)
  (add-hook 'prog-mode-hook 'flyspell-prog-mode))


;;;;;;;;;;;;;;;;;;
;; Custom paths ;;
;;;;;;;;;;;;;;;;;;

;; Setup custom paths to manually-installed lisp packages.
;; This config handles single *.el files as well as
;; directories of multiple *.el files.
(add-to-list 'load-path "~/.emacs.d/lisp/")
(let ((default-directory "~/.emacs.d/lisp/"))
  (normal-top-level-add-to-load-path '("."))
  (normal-top-level-add-subdirs-to-load-path))

;; Custom themes
(setq custom-theme-directory "~/.emacs.d/custom-themes")


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Custom global manual configuration ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Turn on highlighting of current line
(global-hl-line-mode 1)

;; Underline the current line
;; set-face-attribute hl-line-face nil :underline t)

;; Turn on syntax highlighting
(global-font-lock-mode 1)

;; Turn on visual line wrapping
(global-visual-line-mode t)

;; Show column numbers always
(column-number-mode t)

;; Enforce common line length
(setq-default fill-column 120)
(setq-default auto-fill-function 'do-auto-fill)


;;;;;;;;;;;;;;;;;;;;
;; Org Mode Stuff ;;
;;;;;;;;;;;;;;;;;;;;

;; make org mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; configure TODO process tags
(setq org-todo-keywords
      '((sequence "TODO(t)" "IN-PROGRESS(i!)" "WAIT(w)" "|" "DONE(d)" "OBE(o)")
	(sequence "IDEA(d)" "EVALUATION(e)" "PROJECT(p)" "|" "PUBLISHED(P)" "CANCELED(c)" )))

;; add tags
(setq org-tag-alist '((:startgroup . nil)
		      ("@work" . ?w) ("@school" . ?s) ("@home" . ?h)
		      (:endgroup  . nil)
		      ("Other" . ?o)))

(setq org-agenda-files (list "~/org/gtd/")
      org-refile-targets '((org-agenda-files :maxlevel . 5))
      org-refile-use-outline-path 'file
      org-refile-allow-creating-parent-nodes 'confirm
      org-log-into-drawer t
      org-log-done 'time
      org-log-done 'note
      org-log-redeadline 'time
      org-log-reschedule 'time
      org-priority-highest 1
      org-priority-lowest 5
      org-priority-default 4)

;; convenient key bindings
(define-key global-map "\C-c l" 'org-store-link)
(define-key global-map "\C-c a" 'org-agenda)
(define-key global-map "\C-c c" 'org-capture)
(define-key global-map "\C-c \C-o" 'org-open-at-point)
(define-key global-map "\C-c >" 'org-goto-calendar)
(define-key global-map "\C-c <" 'org-date-from-calendar)

;; Clocking time:
;; --------------
;; C-c C-x C-i -> start clock on current item (clock-in)
;; C-C C-x C-o -> stop the clock (clock-out)
;; C-c C-x C-e -> update teh effort estimate for the current clock task
;; C-c C-x C-q -> cancel the current clock
;; C-c C-x C-j -> jump to headline of currently clocked-in task
;;
;; NOTE: add C-u leader to start, stop, or jump commands to choose from recent list
;;

;; Load Markdown backend exporter
(require 'ox-md)

;; M-x org-agenda # to show the stuck projects
(setq org-stuck-projects
      '("+TODO=\"PROJECT\"" ("TODO") nil ""))

;; Capture templates
(setq org-capture-templates
      '(
	("d" "Idea" entry
	 (file "~/org/gtd/inbox.org")
	 "* IDEA %^{Brief Description}\n:PROPERTIES:\n:CATEGORY: idea\n:END:\nAdded: %U\n%?" :empty-lines 1 :prepend t)

	("i" "Inbox" entry
	 (file "~/org/gtd/inbox.org")
	 "* TODO %^{Brief Description}\nAdded: %U\n%?" :empty-lines 1 :prepend t)

	("n" "Next action" entry
	 (file "~/org/gtd/next.org")
	 "** TODO %^{Brief Description}\nAdded: %U\n%?" :empty-lines 1 :prepend t)

	("w" "Waiting" entry
         (file "~/org/gtd/inbox.org")
         "** WAIT %^{Brief Description}\nAdded: %U\n%?" :empty-lines 1 :prepend t)

	("p" "Project" entry
	 (file "~/org/gtd/project.org")
	 "* PROJECT %^{Brief Description}\n:PROPERTIES:\n:CATEGORY: %^{Id}\n:END:\nAdded: %U\n%?" :empty-lines 1 :prepend t)

	("s" "Someday" entry
	 (file "~/org/gtd/someday.org")
	 "* TODO %^{Brief Description}\nAdded: %U\n%?" :empty-lines 1 :prepend t)
	
	))
(define-key global-map "\C-cc" 'org-capture)


;;;;;;;;;;;;;;;;;;;;;;
;; Starting Buffers ;;
;;;;;;;;;;;;;;;;;;;;;;

(find-file "~/org/gtd/inbox.org")
(find-file "~/org/gtd/next.org")


;;;;;;;;;;;;
;; Themes ;;
;;;;;;;;;;;;
(use-package darktooth-theme
  :ensure t
  :config
  (load-theme 'darktooth t))

(use-package gruvbox-theme
  :ensure t
  :config
  (load-theme 'gruvbox t))

(use-package zenburn-theme
  :ensure t
  :config
  (load-theme 'zenburn t))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(adaptive-wrap auto-package-update badwolf-theme beacon bison-mode buffer-flip cherry-blossom-theme
		   chocolate-theme command-log-mode company-jedi darktooth-theme exotica-theme
		   gnome-c-style gnu-elpa-keyring-update gruvbox-theme hydra jdee json-mode magit
		   minimap multishell night-owl-theme nimbus-theme nlinum no-littering org-roam
		   paganini-theme poker python-black rainbow-mode sed-mode spacemacs-theme swiper
		   vlf which-key yasnippet-classic-snippets zenburn-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

; LocalWords:  setq emacs
