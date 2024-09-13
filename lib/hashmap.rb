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

    hash_code %= 16
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
    # puts @load_factor
  end
 
  def rehash
    # Create a new bucket array with double the size
    new_buckets = Array.new(@buckets.length * 2)
    old_buckets = @buckets
    @buckets = new_buckets
    @count = 0

    # Rehash all the key-value pairs into the new bucket array
    old_buckets.each do |bucket|
      next if bucket.nil?

      bucket.each do |node|
        key = node.value.keys.first
        value = node.value[key]
        set(key, value)  # Re-insert into the new bucket array
      end
    end
  end

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
