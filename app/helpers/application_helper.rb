module ApplicationHelper
  def format_cents_as_dollars(price)
    number_to_currency(price/100.0)
  end
end
