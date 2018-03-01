class SocialAccount < ApplicationRecord
    belongs_to :user
	devise :omniauthable, omniauth_providers: %i[facebook twitter linkedin]

	def self.from_omniauth(auth, current_user, sub_provider)
    social = SocialAccount.where(provider: auth.provider, uid: auth.uid.to_s, sub_provider: sub_provider, user_id: current_user.id).first_or_initialize
    social.uid = auth.uid
    social.provider = auth.provider
    social.token = auth.credentials.token
    social.secret = auth.credentials.secret
    social.name = auth.info.name
    social.email = auth.info.email
    social.image = auth.info.image
    social.sub_provider = sub_provider
    social.save!
  end
end
