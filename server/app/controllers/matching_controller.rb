class MatchingController < ApplicationController
  def home 
    @matches = Profile.all
  end

  private
    def match_alg(profile)
      return []
    end

end
