class ResponseGeneratorController < ApplicationController
  def self.generate_response(success, code, message)
    {success: success, code: code, message: message}
  end
end
