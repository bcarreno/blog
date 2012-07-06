class Message < ActiveRecord::Base
  attr_accessible :body, :email, :name
  validates :email, :body, :presence => true
  validates :email, :format => { :with => /\s*[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\s*/}#, :message => "Only letters allowed" }
end
