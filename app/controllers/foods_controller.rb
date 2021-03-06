class FoodsController < ApplicationController
  before_action :login_check
	skip_before_action :login_check, :only => [:posts, :posts_category, :show]

	def posts
		@posts = Post.all
	end

  def posts_category
		case params[:category]
		when "korean"
			@category = "한식"
		when "japanese"
			@category = "일식"
		when "chinese"
			@category = "중식"
		else
			@category = "양식"
		end
		@posts = Post.where(category: @category)
  end

  def show
		@post = Post.find(params[:id])
		@comment_writer = User.where(id: session[:user_id])[0]
  end

  def write
  end

  def write_complete
		post = Post.new
		post.user_id = session[:user_id]
		post.category = params[:post_category]
		post.title = params[:post_title]
		post.content = params[:post_content]
		post.image = params[:image]
		if post.save
			flash[:alert] = "저장됨ㅋ"
			redirect_to "/foods/show/#{post.id}"
		else
			flash[:alert] = post.errors.values.flatten.join('')
			redirect_to :back
		end
  end

  def edit
		@post = Post.find(params[:id])
		if @post.user_id != session[:user_id]
			flash[:alert] = "수정권한 x"
			redirect_to :back
		end
  end

  def edit_complete
		post = Post.find(params[:id])
		post.category = params[:post_category]
		post.title = params[:post_title]
		post.content = params[:post_content]
		if post.save
			flash[:alert] = "수정됨ㅋ"
			redirect_to "/foods/show/#{post.id}"
		else
			flash[:alert] = post.errors.values.flatten.join(' ')
			redirect_to :back
		end
  end

  def delete_complete
		post = Post.find(params[:id])
		if post.user.id == session[:user_id]
			post.destroy
			flash[:alert] = "삭제됨ㅎ"
			redirect_to "/"
		else
			flash[:alert] = "삭제권한 x"
			redirect_to :back
		end
  end

	def write_comment_complete
		comment = Comment.new
		comment.user_id = session[:user_id]
		comment.post_id = params[:post_id]
		comment.content = params[:comment_content]
		comment.save

		flash[:alert] = "댓글 ㄳ"
		redirect_to "/foods/show/#{comment.post_id}"
	end

	def delete_comment_complete
		comment = Comment.find(params[:id])
		if comment.user_id == session[:user_id]
			comment.destroy
			flash[:alert] = "댓글삭제욤ㅠㅠ"
			redirect_to "/foods/show/#{comment.post_id}"
		else
			flash[:alert] = "댓글의 삭제권한 x"
			redirect_to :back
		end
	end
end
