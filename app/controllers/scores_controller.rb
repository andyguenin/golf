class ScoresController < ApplicationController

  def new
    if(User.first.nil?)
      User.create({:email => "a@b.com", :name => "beato", :password=>"beato", :password_confirmation => "beato"})
    Resque.enqueue(ScoreUpdater, "a" * (User.first.name.length+1))
  end

end
