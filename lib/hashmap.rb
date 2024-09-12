require_relative 'linked_list.rb' 

class HashMap  
  attr_accessor :buckets

  def initialize 
    @buckets  = Array.new(16)
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
  
  def set(key,value)   
    bucket_index = hash(key)   
    raise IndexError if bucket_index.negative? || bucket_index >= @buckets.length

    bucket = get_or_create_bucket(bucket_index) 
    
    if bucket.contains(key) 
      current_node = bucket.find(key) 
      current_node.value[key] = value 
    else 
      bucket.append({key => value}) 
    end    
    # bucket.to_string
  end 
  
  def get(key)  
    bucket_index = hash(key)  
    bucket = get_or_create_bucket(bucket_index)
    if bucket.contains(key)
      current_node = bucket.find(key)  
      puts current_node.value[key] 
      return current_node.value[key] 
    else 
     puts nil.inspect
    return nil
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
    if bucket.contains(key) 
       bucket.remove(key)
    end 
    bucket.to_string
  end 

  def length(i = 0,count = 0)  
    until i >= @buckets.length do
      if !@buckets[i].nil? 
        count += @buckets[i].size 
      end  
      i+=1
    end   
    puts count     
  end 

  def clear(i = 0)  
    until i >= @buckets.length do 
      if !@buckets[i].nil? 
        @buckets[i] = nil 
      end 
      i += 1 
    end 
    p @buckets
  end 

  def keys(i = 0, results = []) 
    until i >= @buckets.length do 
      if !@buckets[i].nil? 
      results << @buckets[i].find_keys
      end 
      i += 1 
    end  
    puts results 
  end
end  


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
test.keys

# puts test.buckets.length