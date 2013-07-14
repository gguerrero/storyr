class StoriesController < ApplicationController
  before_action :authenticate
  before_action :set_user,  only: [:index, :show, :new, :edit]
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  # GET /users/1/stories
  def index
    @stories = @user.stories.paginate(page: params[:page], per_page: 10)
    @title   = "All Stories"
  end

  # GET /users/1/stories/1
  def show
    @title = "Show Story"
  end

  # GET /users/1/stories/new
  def new
    @title = "New Story"
  end

  # GET /users/1/stories/1/edit
  def edit
    @title = "Edit Story"
  end

  # POST /users/1/stories
  def create
    @user = Story.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_path, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1/stories/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user) if current_user.name == @user.name
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1/stories/1
  def destroy
    if current_user? @user and @story.destroy
      flash[:warning] = "Story '#{@story.title}' was destoyed!"
    else
      flash[:error]   = "Imposible to destroy '#{@story.title}' story..."
    end
    redirect_to user_stories_path
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:user_id])
  end

  def set_story
    @story = Story.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def story_params
    params.require(:story).permit(*story_params_white_list)
  end

  # The straight params white list
  def story_params_white_list
    %i(title description tags user_id)
  end
end
