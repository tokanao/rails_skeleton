class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # before_action :require_login

  add_flash_types :success, :info, :warning, :danger

  helper_method :model_class, :model_instance

  class << self
    def sys_date
      Time.zone.today
    end

    def sys_time
      Time.current
    end
  end

  def model_class
    controller_name.classify.constantize
  end

  def model_instance
    eval("@#{model_class.to_s.underscore}")
  end

  def sys_date
    self.class.sys_date
  end

  def sys_time
    self.class.sys_time
  end

  private

  def not_authenticated
    redirect_to login_path, alert: "Please login first"
  end
end
