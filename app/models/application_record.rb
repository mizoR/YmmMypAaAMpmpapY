class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.not_found
    @not_found ||= new.tap { |o| o.errors.add(:base, 'Not found') }
  end
end
