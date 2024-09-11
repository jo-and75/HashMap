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
    bucket.to_string
  end 
  
  def get(key)  
    bucket_index = hash(key)  
    bucket = get_or_create_bucket(bucket_index)
    if bucket.contains(key)
      current_node = bucket.find(key) 
      result = current_node.value[key] 
    else 
      result = nil 
    end 
    puts result.inspect
  end 
end  


test = HashMap.new  
test.set('Josh', 'Andy') 
test.set('Josea', 'Rose') 
test.get('Josh')