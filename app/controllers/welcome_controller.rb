class WelcomeController < ApplicationController

  def index
  end
  
  def create_fake_user
    for i in 0..40
      @first_name = Faker::Name.first_name
      @last_name = Faker::Name.last_name
      @user = User.new(
        :first_name => @first_name,
        :last_name => @last_name,
        :email => Faker::Internet.email(@first_name + "." + @last_name),
        :password_digest => Faker::Internet.password,
        :gender => "female",
        :age => 20 + Random.rand(30)
      )
      @user.save!
    end
  end
  
  def create_fake_event
    for i in 0..4
      @event = Event.new(
        :title => Faker::Hipster.word,
        :description => Faker::Hipster.sentence,
        :address => Faker::Address.street_address,
        :city => Faker::Address.city,
        :province => Faker::Address.state,
        :postalcode => Faker::Address.postcode,
        :country => Faker::Address.country,
        :datetime => Faker::Time.between(DateTime.now - 1, DateTime.now + 50),
        :event_type => 1 + Random.rand(3)
      )
      @event.save!
    end
  end
  
end
