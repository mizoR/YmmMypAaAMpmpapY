module RequestSpecDefaultHeaders
  extend ActiveSupport::Concern

  included do
    let(:headers) do
      { 'CONTENT_TYPE' => 'application/json' }
    end
  end
end
