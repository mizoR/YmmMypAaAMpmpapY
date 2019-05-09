class Token < ApplicationRecord
  belongs_to :user

  def self.issue
    create!(access_token: SecureRandom.hex(32))
  end

  def self.unauthorized
    @unauthorized ||= new.tap { |token| token.errors.add(:base, 'Unauthorized') }
  end

  def self.forbidden
    @forbidden ||= new.tap { |token| token.errors.add(:base, 'Forbidden') }
  end
end
