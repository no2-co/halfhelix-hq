class Client < ApplicationRecord

  validates :name, :presence => true
  # validates :email, :format => { :with => /^(.+@.+\..+)?$/, :message => "is not a valid email address." }
end
