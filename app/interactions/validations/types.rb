module Validations
  module Types
    include Dry.Types()

    Email = Types::String.constructor { |s| s.strip.downcase }
  end
end
