;(import (scheme list))
(import (srfi 1))

(define (flatten params)
  (apply append params))

(define (flat-map . params)
  (flatten (apply map params)))

(define head car)
(define tail cdr)
(define fst car)
(define snd cdr)

(define (try-force v)
  (cond
    ((promise? v) (force v))
    (else v)))

(define (say . args)
  (for-each
    (lambda (arg)
      (display arg)
      (display " "))
    args)
  (newline))

(define-record-type
  <parser>
  (parser
    alternatives)
  parser?
  (alternatives parser-alternatives))

(define-record-type
  <single-parser>
  (single-parser
    input
    continuation)
  single-parser?
  (input single-parser-input)
  (continuation single-parser-continuation))

(define-record-type
  <codepoint-input>
  (codepoint-input
    value)
  codepoint-input?
  (value codepoint-input-value))

(define-record-type
  <end-input>
  (end-input)
  end-input?)

(define-record-type
  <end-input>
  (end-input)
  end-input?)

(define-record-type
  <no-input>
  (no-input)
  no-input?)

(define (codepoint value)
  (parser
    (list
      (single-parser
        (codepoint-input value)
        (lambda (next input)
          (say "Codepoint" input)
          (next input))))))

(define end
  (parser
    (list
      (single-parser
        (end-input)
        (lambda (next input)
          (next #f))))))

(define (pure value)
  (parser
    (list
      (single-parser
        (no-input value)
        (lambda (next input)
          (next value))))))

(define (choose . alts)
  (parser
    (flat-map
      (lambda (alt)
        (parser-alternatives
          (cond
            ((promise? alt) (force alt))
            (else alt))))
      alts)))

(define (map-parser f p)
  (say "(map-parser)")
  (parser
    (map
      f
      (parser-alternatives (try-force p)))))

(define (raise-one f x)
  (say "(raise-one)")
  (map-parser
    (lambda (s-x)
      (single-parser
        (single-parser-input s-x)
        (lambda (next-x input-x)
          ((single-parser-continuation s-x)
            (lambda (new-input-x)
              (next-x (f new-input-x)))
            input-x))))
    x))

(define (raise-two f x y)
  (define (transform-x s-x)
    (single-parser
      (single-parser-input s-x)
      (lambda (next-x input-x)
        ((single-parser-continuation s-x)
          (lambda (new-input-x)
            (say "(raise-two new-input-x)")
            (map-parser (transform-y next-x new-input-x) y))
          input-x))))
  (define (transform-y next-x new-input-x)
    (lambda (s-y)
      (single-parser
        (single-parser-input s-y)
        (lambda (next-y input-y)
          ((single-parser-continuation s-y)
            (lambda (new-input-y)
              (next-x (f new-input-x new-input-y)))
            input-y)))))
  (say "(raise-two)")
  (map-parser
    transform-x
    x))

(define (curry f arity)
  (define (compose next)
    (lambda (prev)
      (lambda (current)
        (next (cons current prev)))))
  (define (loop count)
    (cond
      ((= count 0)
        (lambda (args) (apply f args)))
      (else
        (compose
          (loop (- count 1))))))
  ((loop arity) '()))

(define (raise f . args)
  (define (loop head-arg tail-args)
    (cond
      ((null? tail-args)
        (raise-one
          (curry f (length args))
          head-arg))
      (else
        (raise-two
          (lambda (current next) (next current))
          head-arg
          (delay (loop (head tail-args) (tail tail-args)))))))
  (say "(raise)")
  (loop (head args) (tail args)))

(define (some p)
  (say "(some)")
  (letrec
    ((some-p
      (delay 
        (choose
          (raise list p)
          (raise cons p some-p)))))
    some-p))

(define (run parser items)
  (define (advance-no-input p)
    (parser
      (flat-map
        (lambda (s)
          (cond
            ((no-input? (single-parser-input s))
              (
  (define (run-one parser input match? success?)
    (define matching
      (begin (say "Matching" input)
      (filter
        (lambda (single-parser)
          (match? (single-parser-input single-parser)))
        (parser-alternatives parser))))
    (define advanced
      (begin (say "Advancing" input)
      (map
        (lambda (s)
          ((single-parser-continuation s)
            (lambda (new-input)
              new-input)
            input))
        matching)))
    (define successful
      (filter
        success?
        advanced))
    (cond
      ((null? successful)
        (say "Unexpected" input)))
    successful)
  (define (run-one-continue input parser)
    (apply
      choose
      (run-one
        parser
        input
        (lambda (i)
          (and
            (codepoint-input? i)
            (eq? (codepoint-input-value i) input)))
        parser?)))
  (define (run-one-end parser)
    (head
      (run-one
        parser
        #f
        end-input?
        (lambda (value) (not (parser? value))))))
  (run-one-end
    (fold
      run-one-continue
      parser
      items)))

(define (test)
  (define (f x y z)
    (list x y))
  (define (compose next)
    (lambda (prev)
      (lambda (current)
        (next (cons current prev)))))
  (run
    (raise-two
      (lambda (x yz) (yz x))
      (codepoint 'a)
      (raise-two
        (lambda (y z) (z y))
        (codepoint 'b)
        (raise-one
          ((compose (compose (compose (lambda (xyz) (apply f xyz)))))
            '())
          end)))
    '(a b)))

(define (test2)
  (define (f x y z)
    (list 1 x 2 y))
  (run
    (raise-two
      (lambda (xy z) (xy z))
      (raise-two
        (lambda (x y)
          (lambda (z)
            (f x y z)))
        (codepoint 'a)
        (codepoint 'b))
      end)
    '(a b)))

(define (test3)
  (define (f x)
    (list 'a 'b))
  (run
    (raise-one
      f
      end)
    '()))

(define (test4)
  (define (f x y z)
    (list y 7 x x x))
  (run
    (raise
      f
      (codepoint 'a)
      (choose
        (codepoint 'b)
        (codepoint 'c))
      end)
    '(a c)))

(define (test5)
  (define (f x y)
    (cons (length x) x))
  (run
    (raise
      f
      (some (codepoint 'a))
      end)
    '(a a a a)))

  ; Take one input
  ; For each parser that matches
  ; Collect the applicators
  ; At the end, re-run each character through the collected applicators
  ; Applicator takes previous value plus current new input
