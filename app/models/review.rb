class Review
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    customer_id: "INTEGER",
    restaurant_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id



  def customer
    sql = <<-SQL
    SELECT customers.name
    FROM customers
    JOIN reviews
    ON customers.id = reviews.customer_id
    WHERE reviews.customer_id = #{self.customer_id}
    SQL
    DB[conn:].execute(sql)
  end

  def restaurant
    sql = <<-SQL
    SELECT restaurants.*
    FROM restaurants
    JOIN reviews
    ON reviews.restaurant_id = restaurant.id
    WHERE reviews.restaurant_id = #{self.restaurant_id}
    SQL
    DB[conn:].execute(sql)
  end

end
