---
title: SimpleDiff in Python
date: February 13, 2008
type: post
layout: post
---
A while ago I posted a <a href="http://www.paulbutler.org/archives/a-simple-diff-algorithm-in-php/">PHP implementation</a> of a diff algorithm I came up with<sup>1</sup>. Since it was well received, and it’s a useful little algorithm to have, I created a Python version as well.

There are a few performance improvements as well. The PHP version creates an array in memory proportional to the square of the size of the input, while the Python version’s array is directly proportional to the size of the input. I also sped up how the algorithm finds the indexes of the “new” elements in the “old” array.

Update: As of 2009, [the code is hosted on GitHub](https://github.com/paulgb/simplediff).

<sup>1</sup> It is probably the same algorithm that others use, but I haven’t gotten around to getting an ACM membership to access the related papers
