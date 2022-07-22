class HomeController < ApplicationController
  def index
    redirect_to ('../../build/index.html')  
  end
end
