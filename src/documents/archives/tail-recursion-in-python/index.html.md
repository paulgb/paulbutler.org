---
title: Tail Recursion in Python
date: December 13, 2007
type: post
layout: post
---
After spending a lot of time in Scheme, it’s hard not to think in recursion from time to time. When I recently started to improve my Python skills, I missed having Scheme optimize my tail recursive calls.

For example, consider the mutually recursive functions <code>even</code> and <code>odd</code>. You know a number, <em>n</em>, is even if it is 0, or if <em>n</em> – 1 is odd. Similarly, you know a number is not odd if it is 0, and that it is odd if <em>n</em> – 1 is even. This translates to the python code:

    def even(x):
      if x == 0:
        return True
      else:
        return odd(x - 1)

    def odd(x):
      if x == 0:
        return False
      else:
        return even(x - 1)

This code works, but only for <em>x</em> < 1000, because Python limits the recursion depth to 1000. As it turns out, it is easy to get around this limitation. Included below is a generic <code>tail_rec</code> function that could be used for most cases where you need tail recursion, and an example of it used for the odd/even problem.

    def tail_rec(fun):
       def tail(fun):
          a = fun
          while callable(a):
             a = a()
          return a
       return (lambda x: tail(fun(x)))

    def tail_even(x):
      if x == 0:
        return True
      else:
        return (lambda: tail_odd(x - 1))

    def tail_odd(x):
      if x == 0:
        return False
      else:
        return (lambda: tail_even(x - 1))

    even = tail_rec(tail_even)
    odd = tail_rec(tail_odd)

It’s not as pretty as the Scheme version, but it does the trick. Of course, the odd/even functions are just for the sake of a simple example and have no real-world use, but the <code>tail_rec</code> function could be used in practice.

<strong>April 2009 Update</strong>: this article has recently had some popularity. One of the more common comments is that tail_rec could be used as a decorator. In fact, this isn’t true, because <code>even</code> and <code>odd</code> need access to the raw, undecorated versions of each other in the creation of the lambda.

