class UsersController < ApplicationController
  def signup
  end

  def signup_complete
		user = User.new
		user.username = params[:username]
		if params[:password] = params[:retype_password]
			user.password = params[:password]
			if user.save
				flash[:alert] = "님 가입ㅋ 족쇄 참ㅋ"
				redirect_to "/"
			else
				flash[:alert] = user.errors.values.flatten.join(' ')
				redirect_to :back
			end
		else
			flash[:alert] = "비번 틀림"
			redirect_to :back
		end
  end

  def login
  end

  def login_complete
		user = User.where(username: params[:username])[0]
		if user.nil?
			flash[:alert] = "wrong IDorPW"
			redirect_to :back
		elsif user.password != params[:password]
			flash[:alert] = "wrong IDorPW"
			redirect_to :back
		else
			session[:user_id] = user.id
			flash[:alert] = "성공적으로 로그인하였습니다"
			redirect_to "/"
		end
  end

  def logout_complete
  end
end
