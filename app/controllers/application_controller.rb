class ApplicationController < ActionController::API
  include Decoder
  before_action :authenticate
  
end
