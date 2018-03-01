class SocialCategoriesController < ApplicationController
	def index
		@social_categories = current_user.social_categories.all
	end

	def new
		@social_category = current_user.social_categories.new
	end

	def create
		@social_category = current_user.social_categories.new(social_categories_params)
		@social_category.save
		redirect_to user_social_categories_path(current_user.id)
	end

	private
	def social_categories_params
		params.require(:social_category).permit(:name, :active, :user_id)
	end
end
