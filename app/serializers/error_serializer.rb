class ErrorSerializer < ActiveModel::Serializer
  attributes :errors

  def errors
    resource = object.model_name.name

    object.errors.to_hash(true).map do |field, messages|
      messages.map do |message|
        {
          resource: resource,
          field:    field,
          message:  message,
        }
      end
    end.flatten
  end
end
