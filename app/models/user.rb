class User < ActiveRecord::Base
  has_many :todos

  REQUIRED_FIELDS = {
    :nickname => "nickname",
    :fullname => "fullname"
  }

  OPTIONAL_FIELDS = {
    :email => "email",
    :birth_date => "dob",
    :gender => "gender",
    :postcode => "postcode",
    :country => "country",
    :language => "language",
    :timezone => "timezone"
  }

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :trackable, :validatable
  devise :database_authenticatable, :rememberable, :trackable
  
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation

  def password_required?
    false
  end

  class << self
    def required_open_id_fields
      REQUIRED_FIELDS.values
    end

    def optional_open_id_fields
      OPTIONAL_FIELDS.values
    end
  end

  def extract_open_id_values(response)
    profile_data = {}
    [OpenID::SReg::Response, OpenID::AX::FetchResponse].each do |response_class|
      data_response = response_class.from_success_response(response)
      profile_data.merge!(data_response.data) if data_response
    end

    [REQUIRED_FIELDS, OPTIONAL_FIELDS].each do |fields|
      fields.each do |model_key, profile_key|
        unless profile_data[profile_key].blank?
          self.send("#{model_key}=", profile_data[profile_key])
        end
      end
    end
    self.identity_url = response.identity_url
    self.nickname ||= identity_url
  end
end
