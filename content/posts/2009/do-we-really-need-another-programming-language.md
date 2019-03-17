---
title: Do we Really Need Another Programming Language?
date: 2009-11-11
visible: true
---
Yesterday, a group inside Google released a new programming language called <a href="http://golang.org">go</a>. Among the many comments on the new language, I noticed a number of people rhetorically asking if there is really room for more programming languages. I’ve seen the same sentiment expressed before, seemingly whenever someone releases a pet language (Arc, Factor) or rediscovers an older programming language (Smalltalk, Erlang, LISP).

I’m convinced that there is, in fact, room for more programming languages.

I recently read The Mythical Man Month, the 1975 classic about software engineering. Two things stuck out at me. First, that compared to programmers in 1975, programmers today are spoiled by hardware. Many software constraints, like memory and CPU speed — let alone the size of the program on disk — are not issues worth much thought for many software projects. There are of course exceptions: low-level systems code, graphics, data-intensive calculations (in other words, “the fun stuff”) — but in general, application programmers face far fewer constraints than they did 35 years ago. The second thing that struck me is how comparatively little programming has changed since then. Despite the loosening of constraints, we still write applications that, say, directly use pointer arithmetic and manually allocate and deallocate memory.

It’s not just C++, either. Here’s an experiment. Consider the last program you wrote in any language. Imagine you had to describe, in plain English, your program. The description must be complete enough that another programmer could read it and produce your program. Not your program exactly, of course, but one that satisfies the same requirements your program does. (If you actually try this, you may get something that looks like it was written by a lawyer who charges by the comma. That’s fine.)

Now compare your description to the program’s source code. The source code is almost certainly several times longer, less intuitive, and less descriptive. And yet, if your description is precise enough, all the source code does is communicate the same idea to the compiler.

There are two main things that differentiate the source from your description. One is that the source is designed so that a computer can parse it. This amounts to having some regular structure and a well-defined meaning to all the symbols. The other difference is that the description defines <strong>what</strong> the program should do, and the source describes <strong>how</strong>. These differences both contribute to the verbosity of the source code, but I suspect the latter contributes more (consider how concise formal math notation can be, despite having structure and being well-defined).

The obvious way to make a language more expressive, then, is to make it more declarative — to describe <em>what</em> the program does, not <em>how</em> it does it. Ideally our programs could be completely declarative. We could translate the description we wrote for the experiments a few paragraphs back into a more formal language, without adding any implementation details. Then we would have a compiler that created a program which satisfied our description and produced an executable. This type of programming is actually possible in certain, constrained domains (SQL and Prolog, for example), but unfortunately there isn’t a good general algorithm to translate any program we describe declaratively into machine instructions.

The best we can do, then, is to give imperative languages more declarative features. In fact, many high-level language features fall under this category. Take continuations, which let you say “resume code at this point” instead of how “store these pieces of state there, then restore the state and return here when called”. Or list comprehensions, which let you say “give me a list satisfying these properties”, rather than “loop through these elements and do that to them, discarding them if this is not true”. Or iteration constructs, which let you say “do this stuff for each element in that”, without specifying that space must be allocated for a counter, how to look up each element, or that the counter is incremented after each element.

All of those concepts have existed for decades. When available, they make code easier to write, understand, and modify. But even today, if you want to develop a native, cross-platform application, you have to give them all up or resort to using a relatively obscure language like Haskell.

It’s unfair to expect C++ to evolve to support these features, because it has decades of legacy code that it must be backwards compatible with. The language must be improved by either breaking legacy code or adding language features in an awkward sort of tacked-on way. Neither works very well, so the language evolves slowly or not at all.

I don’t mean to knock C++; sometimes it’s exactly what the problem needs. But I think a lot of programmers’ time is wasted solving high level problems with low level tools.

I’m doubtful that any one language will ever be the right tool for every job. Certain abstractions work well with certain domains (continuations with web programming, the actor model with concurrency, etc.), and abstractions that are baked into the language tend to have advantages to those that aren’t.

That’s why I welcome new programming languages. And as long as programming languages are less expressive than written English, I’ll keep welcoming them.

