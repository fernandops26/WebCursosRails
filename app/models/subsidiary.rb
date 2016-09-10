class Subsidiary < ActiveRecord::Base
  belongs_to :person
  belongs_to :programation

  after_initialize :set_defaults

  private
  def set_defaults
    if self.new_record?
      self.leido ||= false
      self.estado ||=false
    end
  end
end
