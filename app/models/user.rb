class User < ApplicationRecord
  enum status: {member: 0, admin: 1}
  has_secure_password

  def self.digest string
    cost =  if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else
              BCrypt::Engine.cost
            end
    BCrypt::Password.create string, cost: cost
  end
end
