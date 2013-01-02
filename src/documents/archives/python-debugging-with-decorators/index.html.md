---
title: Python Debugging with Decorators
date: June 22, 2008
type: post
layout: post
---
I’ve written a little python function which I have found to be very helpful for debugging. It takes a function, and returns a function which is identical to the original except that it prints a message to the console with useful information every time the function is called or returns.

Here is the function:

    # Number of times to indent output
    # A list is used to force access by reference
    __report_indent = [0]

    def report(fn):
        """Decorator to print information about a function
        call for use while debugging.
        Prints function name, arguments, and call number
        when the function is called. Prints this information
        again along with the return value when the function
        returns.
        """

        def wrap(*params,**kwargs):
            call = wrap.callcount = wrap.callcount + 1

            indent = ' ' * __report_indent[0]
            fc = "%s(%s)" % (fn.__name__, ', '.join(
                [a.__repr__() for a in params] +
                ["%s = %s" % (a, repr(b)) for a,b in kwargs.items()]
            ))

            print "%s%s called [#%s]"
                % (indent, fc, call)
            __report_indent[0] += 1
            ret = fn(*params,**kwargs)
            __report_indent[0] -= 1
            print "%s%s returned %s [#%s]"
                % (indent, fc, repr(ret), call)

            return ret
        wrap.callcount = 0
        return wrap

The function can be used as a decorator. For example, in this simple (and inefficient) recursive Fibonacci sequence function:

    @report
    def fibonacci(n):
        if n in [0,1]:
            return n
        else:
            return fibonacci(n - 1) + fibonacci(n - 2)</pre>

The result:

    >>> fibonacci(4)
    fibonacci(4) called [#1]
     fibonacci(3) called [#2]
      fibonacci(2) called [#3]
       fibonacci(1) called [#4]
       fibonacci(1) returned 1 [#4]
       fibonacci(0) called [#5]
       fibonacci(0) returned 0 [#5]
      fibonacci(2) returned 1 [#3]
      fibonacci(1) called [#6]
      fibonacci(1) returned 1 [#6]
     fibonacci(3) returned 2 [#2]
     fibonacci(2) called [#7]
      fibonacci(1) called [#8]
      fibonacci(1) returned 1 [#8]
      fibonacci(0) called [#9]
      fibonacci(0) returned 0 [#9]
     fibonacci(2) returned 1 [#7]
    fibonacci(4) returned 3 [#1]
    3

The level of indent reflects the level of recursion, and the `[#...]` at the end of each line is the number of times the function has been called.

The level of indent is independent of the function being called, so it is helpful with mutual recursion as well. For example, when used with the functions <code>even</code> and <code>odd</code> from my earlier <a href="http://www.paulbutler.org/archives/tail-recursion-in-python/">post on tail recursion</a>, the result looks like this:

    >>> even(5)
    even(5) called [#1]
     odd(4) called [#1]
      even(3) called [#2]
       odd(2) called [#2]
        even(1) called [#3]
         odd(0) called [#3]
         odd(0) returned False [#3]
        even(1) returned False [#3]
       odd(2) returned False [#2]
      even(3) returned False [#2]
     odd(4) returned False [#1]
    even(5) returned False [#1]
    False

I find it useful to stick <code>@report</code> before the function I am having trouble with, and use comments to turn it on and off while I’m debugging that function. It can also be used at times other than function declaration, for example: <code>report(base64.encodestring)(‘test’)</code>.

<strong>Update (July 6, 2008)</strong>: Fixed so that keyword arguments are printed as well.

<strong>Update (August 16, 2008)</strong>: Changed .__repr__() to the more proper repr().

