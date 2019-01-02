class PhotoSerializer
  include FastJsonapi::ObjectSerializer
  attributes :url, :filename_width, :filename_height

  attribute :url do |obj|
    obj.filename.url
  end
end
