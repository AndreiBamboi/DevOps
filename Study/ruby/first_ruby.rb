END {
   puts "Terminating Ruby Program"
}
BEGIN {
   puts "Initializing Ruby Program"
}

class Customer
    @@no_of_cutomers = 0
    def initialize (id, name, addr)
    @cust_id = id
    @cust_name = name
    @cust_addr = addr
    end
    cust1 = Customer.new("1", "John", "Wisdom Apartments, Ludhiya")
    cust2 = Customer.new("2", "Poul", "New Empire road, Khandala")
    puts cust1.cust_name;
end


