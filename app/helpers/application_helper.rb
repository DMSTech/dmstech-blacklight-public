module ApplicationHelper
  def render_manuscript_thumbnail document, image_options = {}
    image_options[:size] ||= 'thumb'
    manuscript_number = get_manuscript_number(document)
    thumbnail = nil 
    if manuscript_number and PARKER_MASTER.has_key?(manuscript_number)
      druid = PARKER_MASTER[manuscript_number]['druid']
      thumbnail = image_tag get_preview_image(document, druid, image_options[:size]), :alt => 'Manuscript preview', :class => 'thumbImg'
    end

    # check if manuscript belongs to e-codices collection and get thumbnail
    if document.first('collection_display').to_s == 'Swiss Medieval Manuscripts'
      thumbnail = image_tag get_ecodices_thumb(document['collection_id']), :alt => 'Manuscript preview', :class => 'thumbImg'
    end

    content_tag :div, thumbnail, :class => 'document-thumbnail'
  end

  def get_manuscript_number(document)
    return nil if document['collection_display'].nil?
    if document['collection_display'].include? 'Parker Medieval Manuscripts'
      manuscript_number = document.first('idno_display').to_s.sub('CCCC MS ', '')
      if manuscript_number =~ /^\d$/
        manuscript_number = manuscript_number.to_i
      end
      return manuscript_number
    end
  end

  def get_preview_image(document, druid, size)
    thumbnails = get_imagestack_thumbnails(document)
    middle_image_index = thumbnails[:images].length / 2
    middle_image = thumbnails[:images][middle_image_index]
    preview_image_url = "/image/#{druid}/#{middle_image}/#{size}"
    return preview_image_url
  end

  def get_ecodices_thumb(xmlid)
    thumb_url = "http://www.e-codices.unifr.ch/api/mobile/getPreviewImage/#{xmlid}"
    return thumb_url
  end

  def get_imagestack_thumbnails(document)
    return nil if document['collection_display'].nil?

    if document['collection_display'].include? 'Parker Medieval Manuscripts'
      manuscript_number = document.first('idno_display').to_s.sub('CCCC MS ', '')

                if manuscript_number =~ /^\d$/
        manuscript_number = manuscript_number.to_i
      end

      # We need to change 524/524_fib.jpg to 524_fib_46
      thumbnails = Hash.new
      processed_images = Array.new
      images = PARKER_MASTER[manuscript_number]['pages'].split(',')

      images.each do |image|
        image_parts = image.split('.jp2')
        processed_images << image_parts[0]
      end

                thumbnails[:images] = processed_images
                thumbnails[:titles] = PARKER_MASTER[manuscript_number]['titles'].split(',')
                thumbnails[:widths] = PARKER_MASTER[manuscript_number]['widths'].to_s.split(',')
                thumbnails[:heights] = PARKER_MASTER[manuscript_number]['heights'].to_s.split(',')
                return thumbnails
    else
      return nil
    end
  end

    def get_imagestack_thumbnails_for_ms(manuscript_number)
      if manuscript_number.is_number?
        manuscript_number = manuscript_number.to_i
      end

      thumbnails = Hash.new
      processed_images = Array.new
      images = PARKER_MASTER[manuscript_number]['pages'].split(',')

      images.each do |image|
        image_parts = image.split('.jp2')
        processed_images << image_parts[0]
      end

                thumbnails[:images] = processed_images
                thumbnails[:titles] = PARKER_MASTER[manuscript_number]['titles'].split(',')
                thumbnails[:widths] = PARKER_MASTER[manuscript_number]['widths'].to_s.split(',')
                thumbnails[:heights] = PARKER_MASTER[manuscript_number]['heights'].to_s.split(',')
                return thumbnails
  end


  def get_field_values document, field, field_config, options = {}
    value = super
    if field.to_s =~ /_url$/
      Array(value).map do |v|
        link_to v, v
      end
    else
      value
    end
  end

  def get_manuscript_druid document
    manuscript_number = get_manuscript_number(document)
    if manuscript_number and PARKER_MASTER.has_key?(manuscript_number)
      PARKER_MASTER[manuscript_number]['druid'] 
    end
  end

  def create_headline(document)
    headline = "<strong>#{document['qualified_idno_display']}</strong><br />#{document['material_display']}, #{document['dimensions_display']}, #{document['origDate_display']}<br />#{document['msTitle_display']}".html_safe
    return headline
  end

end
