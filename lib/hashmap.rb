require_relative 'linked_list'

class HashMap
  attr_accessor :buckets, :load_factor

  def initialize
    @buckets  = Array.new(16) 
    @entry_count = 0
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }

    hash_code %= @buckets.length
    hash_code
  end

  def get_or_create_bucket(index)
    if @buckets[index].nil?
      @buckets[index] = LinkedList.new
    else
      @buckets[index]
    end
  end

  def set(key, value)
    bucket_index = hash(key)
    raise IndexError if bucket_index.negative? || bucket_index >= @buckets.length

    bucket = get_or_create_bucket(bucket_index)

    if bucket.contains(key)
      current_node = bucket.find(key)
      current_node.value[key] = value
    else 
      @entry_count += 1
      bucket.append({ key => value }) 
    end 
     @load_factor = @entry_count.to_f / @buckets.length
    bucket.to_string 
    resize if @load_factor >= 0.75
  end

  def resize
    old_buckets = @buckets # Save the old buckets
    @buckets = Array.new(old_buckets.length * 2) # Double the size of the bucket array
    @entry_count = 0 # Reset the entry count because we'll re-add all entries
    rehash(old_buckets) # Call rehash, passing in the old buckets
  end
  
  def rehash(old_buckets)
    old_buckets.each do |bucket| # Now iterate over the old buckets, not the new ones
      next if bucket.nil?
  
      current_node = bucket.head # Traverse the linked list
      until current_node.nil?
        key = current_node.value.keys.first
        value = current_node.value[key]
        set(key, value) # Reinsert into the new resized bucket array
        current_node = current_node.next_node
      end
    end
  end
  

  # def resize
  #   # Create a new bucket array with double the size
  #   new_buckets = Array.new(@buckets.length * 2)
  #   old_buckets, @buckets = @buckets,new_buckets # Swap the old and new buckets  
  #   rehash
  # end 

  # def rehash 
  #   old_buckets = @buckets
  #   i = 0 
  #   until i > old_buckets.length 
  #     if !old_buckets[i].nil?  
  #       current_node = old_buckets[i].head
  #       until current_node.nil? 
  #         key = current_node.value.keys.first 
  #         value = current_node.value[key] 
  #         set(key,value) 
  #         current_node = current_node.next_node
  #       end 
  #     end  
  #     i += 1
  #   end 
  # end

  def get(key)
    bucket_index = hash(key)
    bucket = get_or_create_bucket(bucket_index)
    if bucket.contains(key)
      current_node = bucket.find(key)
      puts current_node.value[key]
      current_node.value[key]
    else
      puts nil.inspect
      nil
    end
  end

  def has?(key)
    bucket_index = hash(key)
    bucket = get_or_create_bucket(bucket_index)
    if bucket.contains(key)
      puts true
    else
      puts false
    end
  end

  def remove(key)
    bucket_index = hash(key)
    bucket = get_or_create_bucket(bucket_index)
    bucket.remove(key) if bucket.contains(key)
    bucket.to_string
  end

  def length(i = 0,count)
    until i >= @buckets.length
      count += @buckets[i].size unless @buckets[i].nil?
      i += 1
    end
    puts count
  end

  def clear(i = 0)
    until i >= @buckets.length
      @buckets[i] = nil unless @buckets[i].nil?
      i += 1
    end
    p @buckets
  end

  def keys(i = 0, results = [])
    until i >= @buckets.length
      results << @buckets[i].find_keys unless @buckets[i].nil?
      i += 1
    end
    puts results
  end

  def values(i = 0, results = [])
    until i >= @buckets.length
      results << @buckets[i].find_values unless @buckets[i].nil?
      i += 1
    end
    puts results
  end

  def entries(i = 0, results = [])
    until i >= @buckets.length
      results << @buckets[i].find_key_value unless @buckets[i].nil?
      i += 1
    end
    puts results.inspect
  end
end
