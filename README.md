eavesdropper
============

The eavesdropper abstracts the logging portion of your code away out of your code.

Things like 

```
result = Blah.do_something(argument)
Rails.logger.info "Did something with #{argument} here and got: #{result}"
result
```

Quickly fill your code with garbage, make things hard to read an allow logging to introduce 
potential bugs.  Instead use

```
Eavesdropper::Eavesdropper.new(Blah).call :do_something, argument
```