# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def render_flash(type, message)
    render turbo_stream: turbo_stream.prepend('flash-messages', partial: 'shared/flash',
                                                                locals: { type:, message: })
  end
end
