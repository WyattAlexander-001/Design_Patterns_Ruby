class BookInStock

  attr_reader :isbn
  attr_accessor :price
  def initialize(isbn, price)
    @isbn = isbn
    @price = Float(price)
  end

  def price_in_cents
    (price * 100).round.to_s + " PRICE IN USA PENNIES!"
  end

  def to_s
    "ISBN: #{@isbn}, price: #{@price}"
  end
end

# ============    

class CsvReader
  def initialize
    @books_in_stock = []
  end

  def read_in_csv_data(csv_file)
    CSV.foreach(csv_file, headers: true) do |row|
      @books_in_stock << BookInStock.new(row['isbn'], row['price'])
    end
  end
end

# b1 = BookInStock.new('isbn1', 10.99)
# b2 = BookInStock.new('isbn2', 12.99)
# b3 = BookInStock.new('isbn3', 14.99)
# b4 = BookInStock.new('isbn4', 16.99)
# b5 = BookInStock.new('isbn5', 18.99)

# puts b1.isbn
# puts b2.isbn
# puts b1.price
# b1.price = b1.price * 0.75
# puts b1.price_in_cents
# puts b1.price
# puts b1
# # toString equivalent
# puts b1.inspect
# puts b1.to_s
