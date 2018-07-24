class User < ActiveRecord::Base
  has_secure_password

  before_validation :remove_blanks_cases

  # validates_with authenticate_with_credentials, :fields => [:email, :password]

  validates :email, :uniqueness => {:case_sensitive => false}, presence: true
  validates :name, presence: true
  validates :password, :confirmation => true
  validates :password_confirmation, presence: true, length: {minimum: 6}


  def authenticate_with_credentials(email, password)
      @user = User.new(email: email.strip, password: password)

      if user && user.authenticate(password)
        @user
      else
        nil
      end

  end

  private

  def remove_blanks_cases
    if self.email
      self.email = self.email.strip
      self.email = self.email.downcase
    end
  end

end
