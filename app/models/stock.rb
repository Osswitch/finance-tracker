class Stock < ApplicationRecord

	has_many :user_stocks
	has_many :users, through: :user_stocks

	def self.new_from_lookup(ticker_symbol)
		begin
			client = IEX::Api::Client.new(publishable_token: 'pk_d0758a13b12e41808838a49953844804')
			looked_up_stock = client.quote(ticker_symbol)
			new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
		rescue Exception => e
			return nil
		end
	end

end
