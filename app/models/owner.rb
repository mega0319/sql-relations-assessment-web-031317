class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id

  def restaurants
    sql = <<-SQL
    SELECT restaurants.name
    FROM restaurants
    JOIN owners
    ON owners.id = restaurants.owner_id
    WHERE owners.id = #{self.id}
    SQL
    DB[conn:].execute(sql)
  end
end
