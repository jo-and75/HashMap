class HashMap  
  attr_accessor :buckets

  def initialize 
    @buckets  = Array.new(16)
  end 

  def hash(key) 
    hash_code = 0
    prime_number = 31
      
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
      
    hash_code
  end 

  def get_or_create_bucket(index)  
    if @buckets[index].nil? 
      @buckets[index] = LinkedList.new 
    else 
      @buckets[index] 
    end
  end 
  
  
end  


test = HashMap.new 