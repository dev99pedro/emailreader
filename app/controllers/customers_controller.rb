class CustomersController < ApplicationController

  def index
    @customers = Customer.all
    respond_to do | format |
      format.html
    end
  end

end
