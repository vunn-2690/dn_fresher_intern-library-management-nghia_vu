class User < ApplicationRecord
  enum status: {member: 0, admin: 1}
end
