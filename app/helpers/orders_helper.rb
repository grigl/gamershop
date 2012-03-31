module OrdersHelper
  def months_with_numbers
    Date::MONTHNAMES[1..12].zip((1..12))
  end
end
