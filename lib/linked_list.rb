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
      puts
    else
      print "(#{node.value}) -> "
      to_string(node.next_node)
    end
  end

  def find_keys(node = @head, results = [])
    return if node.nil?

    results << node.value.keys
    find_keys(node.next_node, results)

    results
  end

  def find_values(node = @head, results = [])
    return if node.nil?

    results << node.value.values
    find_values(node.next_node, results)

   results
  end

  def find(key, node = @head)
    return nil if node.nil?
    return node if node.value.keys.first == key

    find(key, node.next_node)
  end

  def size(list = @head)
    return 0 if list.nil?

    1 + size(list.next_node)
  end

  def remove(key)
    if @head.value.keys.first == key
      puts @head.value[key]
      @head = @head.next_node
    # puts @head.value
    else
      before_desired_node = @head
      before_desired_node = before_desired_node.next_node until before_desired_node.next_node.value.keys.first == key
      desired_node = before_desired_node.next_node.value[key]
      before_desired_node.next_node = unless before_desired_node.next_node.next_node.nil?
                                        before_desired_node.next_node.next_node
                                      end
      puts desired_node
    end
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
