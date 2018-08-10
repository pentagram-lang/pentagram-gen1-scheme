#lang racket/base

(require
  scribble/base
  scribble/core)

(provide
  code
  result
  context
  ergonomics
  determinism
  efficiency)

(define (code . pre-content)
  (nested
    #:style 'code-inset
    (apply verbatim pre-content)))

(define (result . pre-content)
  (nested
    #:style 'code-inset
    (bold (apply tt pre-content))))

(define (note name pre-content)
  (define title (bold (italic name)))
  (define text (apply italic pre-content))
  (nested
    #:style 'inset
    (tabular
      #:sep (hspace 3)
      `((,title ,text)))))

(define (make-note name)
  (lambda pre-content
    (note name pre-content)))

(define context (make-note "Context"))
(define ergonomics (make-note "Ergonomics"))
(define determinism (make-note "Determinism"))
(define efficiency (make-note "Efficiency"))
