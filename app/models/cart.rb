class Cart < ActiveRecord::Base

  has_many :line_items
  has_many :items, through: :line_items
  belongs_to :user

  def total
    self.line_items.collect { |item| item.item.price * item.quantity }.inject(:+)
  end

  def add_item(n)
    found_item = self.line_items.find_by(item_id: n)
    if found_item
      found_item.quantity += 1
      found_item
    else
      self.line_items.build(item_id: n)
    end
  end

end
