class TaskLog < ActiveRecord::Base
  attr_accessible :stderr, :stdout, :purpose

  after_initialize :set_defaults

  def successful?
    stderr.blank?
  end

  private
    def set_defaults
      self.stdout ||= ""
      self.stderr ||= ""
    end
end
