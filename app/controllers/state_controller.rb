class StateController < ApplicationController
  def advance
    Game.last.advance_state
    head 200
  end
end
