class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

            # Method added by Blacklight; Blacklight uses #to_s on your
            # user class to get a user-displayable login/identifier for
            # the account.
            def to_s
              email
            end
          end
