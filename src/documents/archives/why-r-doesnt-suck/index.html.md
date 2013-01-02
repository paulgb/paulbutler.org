---
title: Why R Doesn't Suck
date: June 19, 2010
type: post
layout: post
---
I first encountered the <a href="http://www.r-project.org/">R programming language</a> a few years ago when I needed to make some plots. Although I’ve used it occasionally since, I always considered it a sort of “Perl for statisticians” — a useful swiss-army knife with ugly syntax and inconsistent semantics. My workflow generally involved manipulating the data in Python and using R to make a simple plot, minimizing the amount of R code I wrote as much as possible.

When I recently decided to sit down and properly learn the language, I was pleasantly surprised that underneath the line noise was an interesting and unique language. R is a descendant of LISP and, deep down, maintains some of the beauty its ancestor. It also borrows some unique and interesting features from other functional and dynamic languages.

<h3>Code is Data</h3>

R is true to its LISP roots in that you can create, modify, and evaluate parse trees from the code itself. One way to do so is with the <code>quote()</code> special-function, which returns its argument, unevaluated, as an expression object that can be traversed, modified and evaluated.

A fun (though not especially useful) consequence of this is that you can write an <a href="http://en.wikipedia.org/wiki/Quine_(computing)">expression which returns itself</a> as a quote:

    > (function(x) substitute((x)(x)))(function(x) substitute((x)(x)))
    (function(x) substitute((x)(x)))(function(x) substitute((x)(x)))
    > expression <- (function(x) substitute((x)(x)))(function(x) substitute((x)(x)))
    > expression == eval(expression)
    [1] TRUE

<h3>Optional Laziness</h3>

By default, R uses <a href="http://en.wikipedia.org/wiki/Eager_evaluation">eager evaluation</a>, so expressions are evaluated as soon as they are assigned. However, R takes after functional languages like Haskell and O’Caml in that it allows lazy evaluation, where expressions are only evaluated at the time they are first used.

For example, consider the Haskell code:

    m = sum [1..]

Where <code>sum</code> returns the sum of a list and <code>[1..]</code> is the (infinite) list of all natural numbers. In most languages, the assignment would cause the program to loop forever trying to sum all the natural numbers so it can assign that value to <code>m</code>. In Haskell, the assignment does complete; it simply assigns the expression <code>sum [1..]</code> to <code>m</code> so that it can be evaluated when the value of <code>m</code> is first used.

In R we can accomplish something similar with the <code>delayedAssign()</code> function:

    delayedAssign("m", sum(1:Inf))

Note that in R, unlike O’Caml, the variables may be explicitly made lazy with <code>delayedAssign</code>, but are evaluated automatically when they are used.

Unfortunately, R evaluates lazy variables when they are pointed to by a data structure, even if their value is not needed at the time. This means that infinite data structures, one common application of laziness in Haskell, are not possible in R.

<h3>Operators are functions</h3>

When using higher-order functions, it’s sometimes useful to be able to treat operators as functions. Python accomplishes this in a clunky way: there is an <code>operator</code> module which redefines the built-in operators as functions. R takes a more functional approach. As in Haskell and O’Caml, operators are just syntactic sugar for ordinary functions. Enclosing any operator in backticks lets you use it as if it were an ordinary function. For example, calling <code>\`+\`(2, 3)</code> returns <code>5</code>.

In fact, both the infix and prefix form are indistinguishable once they are parsed.

    > quote(3 + 4) == quote(`+`(3, 4))
    [1] TRUE

One surprising fact in R is that the assignment operators (<code><-</code>, <code><<-</code> and <code>=</code>) are functions like any other. As a result, they can be overwritten or passed around as desired, though neither strikes me as a particularly good idea.

<h3>Continuations</h3>

<a href="http://en.wikipedia.org/wiki/Continuation">Continuations</a> in R are a way of “breaking out” of a computation and jumping down the call stack to return early. The R function <code>callCC()</code> (<strong>call</strong> with <strong>c</strong>urrent <strong>c</strong>ontinuation) takes one argument, a function. It then evaluates that function, passing in a special function as an argument. <code>callCC()</code> then returns the first value that the special function is called with, or the return value of evaluating its argument if the special function is not called before the function returns.

To give you a better idea of what that looks like, consider this example:

    > callCC(function(m) {return(4)})
    [1] 4
    > callCC(function(m) {m(2); return(4)})
    [1] 2

Calling the function <code>m(2)</code> essentially cuts the computation short, drops down in the call stack to <code>callCC</code>, and returns <code>2</code>.

If you’ve used continuations in another language, note that in R the exit function can only be called before <code>callCC()</code> returns. This makes R’s continuation semantics less powerful than those of languages like Scheme, Smalltalk, and Ruby.

R is not without its flaws and legacy baggage (you can trace its roots back to the <a href="http://en.wikipedia.org/wiki/S_(programming_language)">S programming language</a> 35 years ago), but once you learn to use it right, it’s a very powerful and indispensable language.

