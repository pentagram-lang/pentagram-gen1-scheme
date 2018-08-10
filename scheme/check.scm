(define (uncons nothing something x)
  (cond
    ((null? x)
      (nothing))
    (else
      (something (car x) (cdr x)))))

(define-record-type
  <box>
  (box value)
  box?
  (value unbox set-box!))

(define-record-type
  <check-module>
  (check-module
    name
    runs)
  check-module?
  (name check-module-name)
  (runs check-module-runs))

(define-record-type
  <check-run>
  (check-run
    name
    code)
  check-run?
  (name check-run-name)
  (code check-run-code))

(define check/modules (box '()))

(define (begin-check module-name)
  (define runs (box '()))
  (set-box! check/modules
    (cons
      (check-module module-name runs)
      (unbox check/modules)))
  (lambda (run-name run-code)
    (set-box! runs
      (cons
        (check-run run-name code run-code)
        (unbox runs)))))

(define (check/bold text)
  (string-append "\x1B[1m" text "\x1B[22m"))

(define (check/ok text)
  (string-append "\x1B[32m" text "\x1B[39m"))

(define (check/bad text)
  (string-append "\x1B[31m" text "\x1B[39m"))

(define check/current-run-failed (box #f))

(define (check-matches unknown valid)
  (cond
    ((equal? unknown valid)
      (display (check/ok "✔  ")))
    (else
      (display (check/bad "✖  "))
      (set-box! check/current-run-failed #t))))

(define (main)
  (define (loop modules failures)
    (uncons
      (lambda ()
        (reverse failures))
      (lambda (current next)
        (display (check/bold (: current name))) (display "\n")
        (each
          (lambda (run)
            (display "  ") (display (: run name)) (display " ")
            (set-box! check/current-run-failed #f)
            ((: run code))
            (display "\n"))
          (reverse (unbox (: current runs))))
        (display "\n")
        (loop next (cons (unbox check/current-run-failed) failures)))
      modules))
  (define failures
    (loop (reverse (unbox check/modules)) '()))
  (each
    (lambda (failure)
      (display (cond
        (failure (check/bad "✖ "))
        (else (check/ok "✔ ")))))
    failures)
  (display "\n")
  (exit (cond
    ((any? id failures) 1)
    (else 0))))
