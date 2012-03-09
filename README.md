# Trenza

Trenza is the spanish word for *braid* or *plait*.

> plait |plāt, plat| (noun) a single length of hair or other flexible material made up of three or more interlaced strands.

![Trenza](http://dl.dropbox.com/u/521377/trenza_cinco.jpg)

Trenza is also an experiment in dynamic programming inspired by the reading of [Paolo Perrotta](http://twitter.com/nusco)'s [*“Metaprogramming Ruby”*](http://pragprog.com/book/ppmetr/metaprogramming-ruby) (an awesome book, by the way), and in evaluation models and strategies, inspired in my late adventures with [Erlang](http://www.erlang.org/) and [Haskell](http://haskell.org/).

Trenza provides two methods to every Ruby object: `lazy` and `parallel`. Those two methods return an object that behaves exactly the same way the old one, except that, instead or evaluating its methods right away when they're called, they do it in a *lazy* or *parallel* way.

## *Lazy* objects

*Lazy* objects defer the actual evaluation of its methods until the moment it's really needed:

    class Wadus
      def calculate
        # whatever
      end
    end
    
    wadus1 = Wadus.new.lazy
    wadus2 = Wadus.new.lazy
    
    x = wadus1.calculate
    y = wadus2.calculate
    # no calculation is actually done
    
    puts x # now wadus1.calculate is run in order to print it
           # wadus2.calculate never gets run since it's not needed

## *Parallel* objects

*Parallel* objects are similar to *lazy* objects, but instead of deferring the whole evaluation of the method, they start it in the background and follow with your program. Whenever the actual return value is needed, then and only then will your program wait for the calculation to end (in case it hadn't ended already). This way your programs can become massively parallel without changing your programming style at all:

    class Wadus
      def calculate
        # whatever
      end
    end

    wadus1 = Wadus.new.parallel
    wadus2 = Wadus.new.parallel

    x = wadus1.calculate # calculation is started in the background, your program continues
    y = wadus2.calculate # calculation is started in the background, your program continues

    ...
    
    puts x + y # in case they hadn't finished already, now your program will wait for the
               # calculations to finish, since the return values are needed

Please note that Trenza uses the underlying Ruby's `Thread` class implementation, so the actual kind of parallelism achieved depends greatly on the Ruby implementation you're using. Check Ruby 1.8, Ruby 1.9 and JRuby documentation for further details.

## Use cases

Trenza is an experiment and might not have any practical uses apart from that. But if you find one, let me know!

As for me, scripts with lots of I/O waiting (such as scripts that download files) seem a natural fit for `parallel` (see [`examples/downloads.rb`](https://github.com/porras/trenza/blob/master/examples/downloads.rb) for an example).

## Usage

Nothing special: install the gem, require it, call `lazy` or `parallel` when initializing your objects.

## License

Copyright © Sergio Gil, 2012

Licensed under the [MIT license](http://porras.mit-license.org/).