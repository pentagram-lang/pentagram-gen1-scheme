#lang scribble/base
@(require "utils.rkt")

@title{The Tacit Programming Book}

Welcome to Tacit! If you're new, there's a lot to learn here, so take your time. If you're an old hand, just make yourself at home.

Tacit is a new programming language that's designed for @bold{ergonomics}, @bold{determinism}, and @bold{efficiency}. It has a strong opinion that following these three principles will lead to reliable programs and happy programmers.

But before we get into the details, let's be honest: it's the 21@superscript{st} century, and there are lots of great programming languages out there. Pick any language, and you can implement @italic{any} idea that you can possibly imagine.

Why would anyone need a new language? Well, maybe it's naïve, but after years of creating software and using a few of those languages, I think we can still do better.

I'd like you to try to imagine a language that makes it easy for you to express yourself. A language where the lines between building and playing are blurred. A language that's designed just for you.

@italic{If} such a programming language exists, I hope you can find it here, with Tacit.

Language, writing, communication---they're all human constructs, and it's within our power to improve them. If we're willing to take the risk...

@context{No language exists in a vacuum, and I'll try to point out connections as we go. Like how using Haskell opened my eyes to the world of functional programming.}

@include-section["design-principles.scrbl"]
@include-section["building-blocks.scrbl"]
@include-section["tacit.scrbl"]
@include-section["modules.scrbl"]
@include-section["errors.scrbl"]
