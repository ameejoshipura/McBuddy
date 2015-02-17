class ProfilesController < ApplicationController
  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(create_profile_params)
    @profile.save
    redirect_to @profile
  end

  def edit
  end

  def show
    @profile = Profile.find(params[:id])
  end

  private
    def create_profile_params
      params.require(:profile).permit(:name, :bio)
    end
end
