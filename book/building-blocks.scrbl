#lang scribble/base
@(require "utils.rkt")

@title{Building blocks}

@section{Expressions}

The most basic expressions are single values. Here are a couple examples of integers and strings.

@code|{5}|
@result{5}

@code|{"hello"}|
@result{"hello"}

Tacit uses a ``stack'' for expressions.

@code|{5 "hello"}|
@result{5 "hello"}

@code|{5 2 *}|
@result{10}

@code|{"hello" "-world" cat}|
@result{"hello-world"}

@ergonomics{As long as you keep your expressions short (and meaningful) with variables and functions, you'll find that Reverse Polish Notation is a very comfortable form of writing. No order of operations to memorize and no nested parenteses to navigate.}

@section{Assignment}

To store the result of an expression, you can assign it to a variable.

@code|{greeting = "hello"}|

@ergonomics{Notice there are no type delcarations or ``new variable'' notation? All variable assignment is written the same way.}

@determinism{If you ``re-assign'' a varible, it creates a new lexical binding. Any previous references will refer to the previous lexical binding (of the same name) with previous variable contents.}

@section{Experiment: ?}

@section{Definitions}
@section{Conditionals}


@section{Experiment: ?}

