#lang scribble/base
@(require "utils.rkt")

@title{Design principles}

Well, you've made it this far, and you're ready to start your journey. To help you through this, you can approach learning Tacit like you'd approach learning any other human language:

@itemlist[
  #:style 'ordered
  @item{You need some background information first. This will help you see the big picture, and get you ready for what you'll encounter next.}
  @item{The most basic step is learning how to construct and interpret very simple (but still useful) phrases...}
  @item{Followed by lots of hands-on experimentation in a variety of different situations.}
  @item{As phrases turn into sentences and paragraphs, you'll need to keep expanding both your understanding of advanced concepts, and your vocabulary.}]

This chapter is here as a rough guide for what's to come. Here you'll learn the foundations of the Tacit programming language. It won't get too detailed, but it will help introduce you to these concepts. Ergonomics, determinism, and efficiency will come up again and again (and again).

@section{Ergonomics}

Ergonomics is about designing ``things'' to be suitable for humans. Seems like a good idea, right? But it usually ends up the other way: the ``thing'' gets designed (to match some other set of requirements), and the human adapts to the design.

@margin-note{With the rise of modern IDEs, does code really need to be suitable for humans to write? As long as humans are involved, human factors will matter.}

When you think of ergonomics, you might think of office furniture---like desks and chairs---being designed to prevent physical injury, fatigue, and discomfort. But for something like a tool, a user interface, or a language, there are other human factors to consider besides joints and muscles.

For Tacit, here are the human factors that are taken into account:

@itemlist[
  @item{@bold{Fatigue} / Caused easily by repetitive, awkward, and/or confusing tasks, which should be avoided.}
  @item{@bold{Comprehension} / The process of connecting visual glyphs to mental concepts should be as effortless as possible.}
  @item{@bold{Manipulation} / Adding to, removing from, or changing existing code should proceed without snags or interruptions.}
  @item{@bold{Expression} / ``Power'' in programming comes from building sophisticated concepts out of simpler ones---remove all barriers to this task.}]

If this was a natural language, centuries of linguistic evolution would craft a language quite suitable for humans. But with an artificial language like Tacit, we can try to accelerate this evolution---by applying the science of ergonomics.

@context{I've found that Python is a language that's quite easy and comfortable to use, and so I've tried to leverage some of that design into Tacit.}

@ergonomics{Ergonomics will be an ongoing topic, so keep an eye out for notes like this.}

@section{Determinism}
- output determined by inputs
- side effects caused by shared mutable
- call function again
- key to factoring intermediate variables and new functions
- no surprises

@context{Other languages are guided by this principle, including Haskell.}

@determinism{When you see a note like this, the topic being explained is related to code that functions as math.}

@section{Efficiency}
- GC
- call convention
- memory locality
- compile-time code
- "performance" a misnomer, because you just need to get the program to stop doing stuff
  - memory access (including stack push/pop)
  - branching
- 32-bit pointers
- generic specialization

@context{C++ is always held up.}

@efficiency{These notes will call out how a concept is related to efficiency.}
