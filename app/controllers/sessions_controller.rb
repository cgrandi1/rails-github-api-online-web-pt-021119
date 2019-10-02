class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    binding.pry
    resp = Faraday.post("https://github.com/login/oauth/access_token") do |req|
      req.params['client_id'] = ENV['CLIENT_ID']
      req.params['client_secret'] = ENV['CLIENT_SECRET']
      req.params['grant_type'] = 'authorization_code'
      req.params['redirect_uri'] = "http://localhost:3000/auth"
      req.params['code'] = params[:code]
  end
  body = JSON.parse(resp.body)
  session[:token] = body["access_token"]
  redirect_to root_path
end
