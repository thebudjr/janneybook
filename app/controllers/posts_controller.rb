class PostsController < ApplicationController
	before_action :set_post, only: [:edit, :update, :destroy]

	def create
		@post = current_user.posts.new(post_params)
		if @post.save
			respond_to do |format|
				format.html {redirect_to user_path(@post.user.username), notice: "Post Posted"}
			end
		else
			format.html {redirect_to user_path(@post.user.username), notice: "Post Not Saved... Whoops"}
		end
	end

	def destroy
		if @post.destroy
			respond_to do |format|
				format.html {redirect_to user_path(@post.user.username), notice: "Post Removed"}
			end
		else
			format.html {redirect_to post_path(@post), notice: "Post Not Removed... Whoops"}
		end
	end

	def edit
	end

	def update
		if @post.update(post_params)
			respond_to do |format|
				format.html {redirect_to user_path(@post.user.username), notice: "Edit Saved"}
			end
		else
			format.html {redirect_to post_path(@post), notice: "Edit Not Saved... Whoops"}
		end
	end

	private

		def post_params
			params.require(:post).permit(:content)
		end

		def set_post
			@post = Post.find(params[:id])
		end

end