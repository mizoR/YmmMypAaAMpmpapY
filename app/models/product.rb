class Product < ApplicationRecord
  attr_accessor :image_binary

  has_one_attached :image

  belongs_to :owner, class_name: 'User'

  validates :name,
    presence: true,
    length: { in: 1..255 }

  validates :price,
    presence: true,
    numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 1_000_000 }

  validates :image_binary,
    presence: true

  after_save :attach_image

  private

  def attach_image
    return unless @image_binary

    Tempfile.create('product_image') do |io|
      io.binmode

      io.write Base64.decode64(@image_binary)

      io.rewind

      self.image.attach(
        io:           io,
        filename:     "product_images-#{id}.jpg",
        content_type: 'image/jpeg',
      )
    end
  end

  def validate_image_binary
    return unless @image_binary

    binary = Base64.decode64(@image_binary)

    image_size = ImageSize.new(binary)

    case
    when image_size.format.nil?
      errors.add(:image_binary, 'has an invalid content type')
    when image_size.format != :jpeg
      errors.add(:image_binary, 'has an invalid content type')
    when image_size.width == 320
      errors.add(:image_binary, 'width must be equal to 320 pixel')
    when image_size.height == 240
      errors.add(:image_binary, 'height must be equal to 240 pixel')
    end
  end

end
