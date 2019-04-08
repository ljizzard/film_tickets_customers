require_relative('../db/sql_runner')
require_relative('films.rb')
require_relative('customers.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['id'].to_i if options['id']
    @film_id = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO tickets
    (
      customer_id,
      film_id,
    )
    VALUES
    (
      $1, $2
    )
    RETURNING id"
    values = [@customer_id, @film_id]
    tickets = SqlRunner.run( sql,values ).first
    @id = tickets['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    result = tickets.map { |ticket| Ticket.new( ticket ) }
    return result
  end

  def films()
      sql = "SELECT * FROM films WHERE id = $1"
      values = [@film_id]
      film = SqlRunner.run(sql, values)[0]
      return Film.new(film)
  end

    def customers()
      sql = 'SELECT * FROM customers WHERE id = $1'
      values = [@customer_id]
      customer = SqlRunner.run(sql, values)[0]
      return Customer.new(customer)
    end



end
