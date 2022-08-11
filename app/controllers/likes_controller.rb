class LikesController < ApplicationController

    def create
        @like = Like.new(user_id: @current_user.id, post_id: params[:post_id])
        @like.save
        # redirect_back("/users/#{@current_user.id}")
        redirect_back(fallback_location: "/users/#{@current_user.id}")
    end
    
    def destroy
        @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
        @like.destroy
        redirect_back(fallback_location: "/users/#{@current_user.id}")
        # redirect_back("/users/#{@current_user.id}")
        # redirect_to("/posts/#{params[:post_id]}")
    end
    
end