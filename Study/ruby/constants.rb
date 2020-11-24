class Example
    VAR1 = 100
    VAR2 = 200
    def show
        puts "Value of first contant is #{VAR1}"
        puts "Value of second constant is #{VAR2}"
    end
end

object = Example.new()
object.show

foo = 42
defined? foo    # => "local-variable"
defined? $_     # => "global-variable"
defined? bar