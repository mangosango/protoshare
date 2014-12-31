class User
  include Mongoid::Document
  include Mongo::Followable::Followed
  include Mongo::Followable::Follower
  include PublicActivity::Model
  tracked

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  ## Liked Items
  field :liked_items,       type: Hash

  # def self.from_omniauth(auth)
  #   where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     user.email = auth.info.email
  #     user.password = Devise.friendly_token[0,20]
  #   end
  # end

  # def self.create_with_omniauth(auth)
  #   create! do |user|
  #     user.provider = auth.provider
  #     user.uid = auth.uid
  #     if auth.info
  #        user.name = auth.info.name || ""
  #     end
  #   end
  # end

  # def self.serialize_into_session(record)
  #   [record.id.to_s, record.authenticatable_salt]
  # end

  # class << self
  #   def serialize_from_session(key, salt)
  #     record = to_adapter.get(key[0].to_param)
  #     record if record && record.authenticatable_salt == salt
  #   end
  # end

  class << self
    def serialize_from_session(key, salt)
      record = to_adapter.get(key[0]['$oid'])
      record if record && record.authenticatable_salt == salt
    end
    def self.serialize_from_cookie(id, remember_token)
      record = to_adapter.get(id[0]["$oid"])
      record if record && !record.remember_expired? &&
                Devise.secure_compare(record.rememberable_value, remember_token)
    end
  end

end
