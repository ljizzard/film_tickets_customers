require_relative('../db/sql_runner')
require_relative('customers.rb')

class Film

attr_reader :id
attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['tile']
    @price = options['price'].to_i if options['price']
  end

  def save()
      sql = "INSERT INTO films
      (
        title,
        price
      )
      VALUES
      (
        $1, $2
      )
      RETURNING id"
      values = [@title, @price]
      films = SqlRunner.run(sql, values).first
      @id = films['id'].to_i
  end

  def self.all
    sql = "SELECT * FROM films"
    values =[]
    films = SqlRunner.run(sql, values)
    result = films.map { |film| Film.new (film) }
    return result
  end

  def self.delete_all()
      sql = "DELETE FROM films"
      values = []
      SqlRunner.run(sql, values)
  end

  def users()
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets ON customers.id = tickets.user_id
    WHERE tickets.film_id = $1"
    values = [@id]
    results = SqlRunner.run(sql, values)
    return results.map {|customer| Customer.new(customer)}
  end

  def update_films()
    sql = "UPDATE films SET (title, price) = ($1, $2,) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

def tickets
  sql = 'SELECT * FROM tickets WHERE film_id =$1'
  values = [@id]
  results = SqlRunner.run(sql,values)
  return results.map {|ticket| Ticket.new(ticket)}
end





end
