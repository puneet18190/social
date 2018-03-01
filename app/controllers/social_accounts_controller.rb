class SocialAccountsController < ApplicationController
	def index
		@social_accounts = SocialAccount.all
	end

	def create
		provider = params['social_account']['provider']
		uid = params['social_account']['uid']
		sub_provider = params['social_account']['sub_provider']
		user_id = params['social_account']['user_id']
		social = SocialAccount.where(provider: provider, uid: uid, sub_provider: sub_provider, user_id: user_id).first_or_initialize
	    social.uid = uid
	    social.provider = provider
	    social.token = params['social_account']['token']
	    social.secret = params['social_account']['secret']
	    social.user_id = user_id
	    social.name = params['social_account']['name']
	    social.email = params['social_account']['email']
	    social.image = params['social_account']['image']
	    social.sub_provider = sub_provider
	    social.save!
	end
end
