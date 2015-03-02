class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
    # TODO: create in QB, and add QBID to @profile
  end

  def create
    @profile = Profile.new(create_profile_params)
    @profile.save
    redirect_to @profile
  end

  def index
  end

  def edit
    @profile = Profile.find(params[:id])
  end

  def update
    @profile = Profile.find(params[:id])

    if @profile.update(create_profile_params)
      redirect_to @profile
    else
      render 'edit'
    end
  end

  def show
    @profile = Profile.find(params[:id])
  end

  def destroy
    # TODO: check authentication
    @profile = Profile.find(params[:id])
    @profile.destroy
    redirect_to_profiles_path
  end

  private
    def create_profile_params
      params.require(:profile).permit(:name, :bio, :classlist, :schedule)
    end
end
