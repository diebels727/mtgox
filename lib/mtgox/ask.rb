require 'mtgox/offer'
require 'mtgox/value'

module MtGox
  class Ask < Offer
    include MtGox::Value

    def initialize(client, hash = nil)
      self.client = client
      if hash
        self.price = value_currency hash, 'price_int'
        self.amount = value_bitcoin hash, 'amount_int'
        self.timestamp = hash['stamp']
      end
    end

    def eprice
      price / (1 - self.client.commission)
    end

    def <=>(other)
      return(1) if self.amount > other.amount
      return(-1) if self.amount < other.amount
      return(0) if self.amount == other.amount
    end

  end
end
