class Customer
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    birth_year: "INTEGER",
    hometown: "TEXT"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def reviews
    sql = <<-SQL
    SELECT reviews.*
    FROM customers
    JOIN reviews
    ON customers.id = reviews.customer_id
    WHERE reviews.customer_id = #{self.id}
    SQL
    DB[conn:].execute(sql)
  end


end
