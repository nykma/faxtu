module API
  module V1
    class Root < ::API::Root
      version 'v1', using: :accept_version_header

      # Mount points
      mount API::V1::Users
    end
  end
end
