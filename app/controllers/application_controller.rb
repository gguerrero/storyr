class ApplicationController < ActionController::Base
  include SessionsHelper
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_locale

  def default_url_options(options={})
    { :locale => I18n.locale }.merge(options)
  end

  private
  def set_locale
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
