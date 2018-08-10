#lang scribble/base
@(require "utils.rkt")

@title{Tacit}

By now you may notice something odd about Tacit: there's not much written down.

This programming language is based on the idea that tools should be designed with human capabilities in mind. Human weaknesses should be avoided, and human strengths should be put to work.

Humans are great at pattern matching, at understanding and using complex languages. They are also slow at reading and writing verbose text. Why not design a language that tries to make as much communication implicit as possible?

Compare two languages: one is concise and powerful, and assists implicit communication, the other is detailed and verbose, refusing to rely on implicit communication. The Tacit programming language is designed based on the assumption that the concise and powerful language will be a faster and more effective way to accomplish software objectives.

By keeping redundant communication to a minimum, we give free rein to human imagination and intuition (human strengths). We avoid increasing cognitive load with superfluous items (human weakness).

These ideas have been used in computing for years, to great effect. Here are some places where implicit has taken off:

- command line
- type inference
- QuickCheck
- scripting languages
- Lisp macros
- DSLs

The Tacit language builds on what's come before, using implicit communication as a primary goal rather than a side effect of some other goal. In terms of programming language, why not combine the fluidity of scripting languages (where no types are permitted) with the convenience of static type inference (where types are optional but encouraged)?

Warning: in order to convey the same amount of communication implicitly as explicitly, the communication participants need to use a mutually-understood form of compression. This comes in the form of shared principles, processes, philosophies, and paradigms. As you become more familiar with the Tacit programming environment (including the contructs you create yourself), you'll find this form of implicit communication more and more effective.

Flip side: because the Tacit language is itself a software program, the implicit communication of the language can be fully (explicitly) understood by software. Any information known at compile-time (but not explicitly communicated by the programmer) can be presented to the programmer by the compiler. Because Tacit programs are statically typed, there's a lot of information known at compile-time. As you learn to use the REPL and your IDE, you'll encounter these support features.
