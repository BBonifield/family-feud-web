class MessagesController < ApplicationController
  def received
    payload = {
      :text => params[:Body],
      :from => normalized_number(params[:From])
    }
    raise payload.inspect
  end

  protected

  def normalized_number number
    number.gsub(/^\+1/, '')
  end
end
