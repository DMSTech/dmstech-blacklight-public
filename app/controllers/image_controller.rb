class ImageController < ApplicationController

  def stream
    druid = params[:druid]
    file_name = params[:file_name]
    size = params[:size]
    parker_image_access = current_user.nil? ? 0 : current_user.parker_image_access
    # ensure that only small, thumb and square sizes will be returned 
    # TODO: insert logic to return full size images (large, xlarge) for logged in users with privileged access
    if size != 'small' and size != 'thumb' and size != 'square' and parker_image_access != 1
      size = 'thumb'
    end
    image_url = STACKS[:url] + "/image/app/#{druid}/#{file_name}_#{size}"
    file_contents = RestClient.get image_url
    Tempfile.open('temp') do |file|
      file.binmode
      file.write file_contents
      file.flush    # make sure to call flush otherwise the image will not fully render
      send_file file.path, :type => "image/jpeg", :disposition => "inline"
    end
  end
  
  def stream_zoompr
    druid = params[:druid]
    file_name = params[:file_name]
    # default image stacks URL for non-privileged users: small image
    image_url = STACKS[:url] + "/image/app/#{druid}/#{file_name}_small"
    parker_image_access = current_user.nil? ? 0 : current_user.parker_image_access
    # image stacks URL for privileged users
    if parker_image_access == 1
      # marquee image
      if !params['w'].nil? and !params['h'].nil?
        image_url = STACKS[:url] + "/image/app/#{druid}/#{file_name}.jpg?&rotate=#{params['rotate']}&w=#{params['w']}&h=#{params['h']}"
      # main image
      else
        image_url = STACKS[:url] + "/image/app/#{druid}/#{file_name}.jpg?zoom=#{params['zoom']}&region=#{params['region']}&rotate=#{params['rotate']}"
      end
    end
    file_contents = RestClient.get image_url
    Tempfile.open('temp') do |file|
      file.binmode
      file.write file_contents
      file.flush    # make sure to call flush otherwise the image will not fully render
      send_file file.path, :type => "image/jpeg", :disposition => "inline"
    end
  end


end
