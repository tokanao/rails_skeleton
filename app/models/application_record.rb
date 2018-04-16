class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  extend Enumerize

  class << self
    def sys_date
      Time.zone.today
    end

    def sys_time
      Time.current
    end

    def param_names
      column_names - %w[deleted_at created_at updated_at]
    end
  end

  def sys_date
    self.class.sys_date
  end

  def sys_time
    self.class.sys_time
  end
end
