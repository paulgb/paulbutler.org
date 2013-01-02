---
title: A Simple Diff Algorithm in PHP
date: May 15, 2007
layout: post
---
A diff algorithm in its most basic form takes two strings, and returns the changes needed to make the old string into the new one. They are useful in comparing different versions of a document or file, to see at a glance what the differences are between the two. Wikipedia, for example, uses diffs to compare the changes between two revisions of the same article.

Solving the problem is not as simple as it seems, and the problem bothered me for about a year before I figured it out. I managed to write my algorithm in PHP, in 18 lines of code. It is not the most efficient way to do a diff, but it is probably the easiest to understand.

It works by finding the longest sequence of words common to both strings, and recursively finding the longest sequences of the remainders of the string until the substrings have no words in common. At this point it adds the remaining new words as an insertion and the remaining old words as a deletion.

Update: As of 2009, [the code is hosted on GitHub](https://github.com/paulgb/simplediff).
