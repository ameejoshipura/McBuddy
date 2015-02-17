class MatchingController < ApplicationController
  def index
    @matches = Match.all
  end

  def show
    matches = match_alg()
  end

  private
    def match_alg(profile)
      return []
    end

end
