require_relative 'lib/hashmap.rb' 

test = HashMap.new
test.set('Josh', 'Andy')
test.set('Josea', 'Rose')
test.set('Joqus', 'Blue')
test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
# test.has?('Jack')
# test.remove('Joqus')
test.entries
