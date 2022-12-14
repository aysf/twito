class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def index
    # TODO fix
    @posts = Post.all
  end

  def show
    @user = User.find_by(id: params[:id])
    @posts = @user.posts
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(
      name: params[:name], 
      email: params[:email],
      password: params[:password],
      image_name: "0.jpg"
    )
    if @user.save 
      session[:user_id] = @user.id
      flash[:notice] = "You have signed up successfully"
      redirect_to("/")
    else
      flash[:notice] = "fails"
      render("about")
    end
  end

  def login_form
  end
  
  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      puts "kondisi 1"
      session[:user_id] = @user.id
      flash[:notice] = "Login Successfully"
      redirect_to("/posts")
    else
      puts "kondisi 2"
      @error_message = "invalid credential"
      @email = params[:email]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end
    if @user.save
      flash[:notice] = "Your account has been updated successfully"
      redirect_to("/users/#{@user.id}")
    else
      render("users/edit")
    end

  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "You have logged out successfully"
    redirect_to("/login")
  end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    if @current_user.id != params[:id].to_i
      flash[:notice] = "Unauthorized access"
      redirect_to("/posts")
    end
  end

end
