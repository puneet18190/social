class CallbacksController < Devise::OmniauthCallbacksController

  def facebook
    if request.env['omniauth.params']['connect'] == "facebook_profile"
      @user = SocialAccount.from_omniauth(request.env['omniauth.auth'], current_user, "profile")
      redirect_to "/social_accounts"
    elsif request.env['omniauth.params']['connect'] == "facebook_page"
      @social_account = SocialAccount.new
      @data = request.env['omniauth.auth']
      token = @data.credentials.token
      user_graph = Koala::Facebook::API.new(token)
      @pages = user_graph.get_connections("me", "accounts")
      @pages.each do |p|
        p.merge!("is_create" => SocialAccount.where(provider: @data['provider'], uid: p["id"], sub_provider: "page").first.nil?)
      end
      render :facebook_page
    elsif request.env['omniauth.params']['connect'] == "facebook_group"
      @social_account = SocialAccount.new
      @data = request.env['omniauth.auth']
      token = @data.credentials.token
      user_graph = Koala::Facebook::API.new(token)
      @groups = user_graph.get_connections("me", "groups")
      @groups.each do |g|
        g.merge!("is_create" => SocialAccount.where(provider: @data['provider'], uid: g["id"], sub_provider: "group").first.nil?)
      end
      render :facebook_group
    end  
  end

  def twitter
    @user = SocialAccount.from_omniauth(request.env['omniauth.auth'], current_user, "profile")
    redirect_to "/social_accounts"
  end

  def linkedin
    if params["connect"] == "linkedin_profile"
      @user = SocialAccount.from_omniauth(request.env['omniauth.auth'], current_user, "profile")
      redirect_to "/social_accounts"
    elsif params["connect"] == "linkedin_company"
      @social_account = SocialAccount.new
      @data = request.env['omniauth.auth']
      client = LinkedIn::Client.new('', '')
      client.authorize_from_access(request.env['omniauth.auth']["credentials"]["token"],request.env['omniauth.auth']["credentials"]["secret"])
      @companies = client.company({is_admin: "true"}).all
      @companies.each do |c|
        c.merge!(is_create: SocialAccount.where(provider: @data['provider'], uid: c["id"], sub_provider: "company").first.nil?)
      end
      # client.add_company_share("13660716", {comment: "zxcc1"}) # post on linkedin page
    end
  end
end
