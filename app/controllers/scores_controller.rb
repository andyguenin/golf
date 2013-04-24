class ScoresController < ApplicationController

  def new
    User.find(1).update_name
  end

end
