require_relative('../db/sql_runner')
require_relative('tickets.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end

  def save()
    sql = "INSERT INTO customers
    (
      name,
      funds
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@name, @funds]
    customers = SqlRunner.run( sql, values ).first
    @id = customers['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    customers = SqlRunner.run(sql, values)
    result = customers.map { |customer| Customer.new( customer) }
    return result
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    values = []
    SqlRunner.run(sql, values)
  end

def films()
  sql = 'SELECT films.* FROM films
  INNER JOIN tickets ON films.id = tickets.film_id
  WHERE tickets.customer_id = $1'
  values = [@id]
  results = SqlRunner.run(sql, values)
  return results.map{|film| Films.new(film)}
end

def update_customer()
    sql = "UPDATE customer SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
end

def buy_ticket(price)
    @funds -= price
end

end
