class GamesController < ApplicationController
  def show
    g = Game.find_by_id params[:id] rescue nil
    if g
      render :json => g.to_json
    else
      head 404
    end
  end

  def create
    g = Game.create

    render :json => g.to_json
  end
end
