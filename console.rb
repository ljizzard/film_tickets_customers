require ('pry')

require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')



Ticket.delete_all()
Film.delete_all()
Customer.delete_all()

customer1 = Customer.new({'name' => 'Billy Nomates', 'funds' => '25'})
customer1.save()

customer2 = Customer.new({'name' => 'Fred Friends', 'funds' => '30'})
customer2.save()

customer3 = Customer.new({'name' => 'Carol Canny', 'funds' => '10' })
customer3.save()



film1 = Film.new({ 'title' => 'Aliens', 'price' => '7'})
film1.save()

film2 = Film.new({ 'title' => 'Pretty Woman', 'price' => '2'})
film2.save()

film3 = Film.new({ 'title' => 'Inside Out', 'price' => '5'})
film3.save()




ticket1 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film1.id})
ticket1.save()

ticket2 = Ticket.new({ 'customer_id' => customer2.id, 'film_id' => film3.id})
ticket2.save()

ticket3 = Ticket.new({ 'customer_id' => customer3.id, 'film_id' => film2.id})
ticket3.save()

ticket4 = Ticket.new({ 'customer_id' => customer1.id, 'film_id' => film2.id})
ticket4.save()


binding.pry
