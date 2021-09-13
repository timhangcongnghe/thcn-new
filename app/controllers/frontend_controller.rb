require_dependency 'application_controller'

class FrontendController < ApplicationController
  include ApplicationHelper
  
  # before_action :redirect_domain
  # 
	# def redirect_domain
	# 	if request.host == 'www.timhangcongnghe.com'
	# 		redirect_to 'https://timhangcongnghe.com' + request.fullpath, :status => 301
	# 	end
	# end
end