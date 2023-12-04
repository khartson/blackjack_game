class ApplicationRecord < ActiveRecord::Base  
  require 'net/http'
  require 'uri'

  primary_abstract_class

  def build_serialized_json_response(url)
    uri = URI(url)
    response = Net::HTTP.get_response(uri)
    response_body_as_hash = JSON.parse(response.body)
  end 

end
