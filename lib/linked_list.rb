class LinkedList
  def initialize
    @head = nil
  end

  def append(entry)
    if @head.nil?
      @head = Node.new(entry, nil)
    else
      last_node = @head
      last_node = last_node.next_node until last_node.next_node.nil?
      last_node.next_node = Node.new(entry, nil)
    end
  end

  def to_string(node = @head)
    if node.nil?
      print ' nil '
    else
      print "(#{node.value}) -> "
      to_string(node.next_node)
    end
  end

  def find(key, node = @head)
    return nil if node.nil?
    return node if node.value.keys.first == key

    find(key, node.next_node)
  end

  def contains(elem, current = @head)
    if current.nil?
      false
    elsif current.value.keys.first == elem
      true
    else
      contains(elem, current.next_node)
    end
  end

  class Node
    attr_accessor :value, :next_node

    def initialize(value, next_node)
      @value = value
      @next_node = next_node
    end
  end
end
