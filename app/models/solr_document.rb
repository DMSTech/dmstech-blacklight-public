# -*- encoding : utf-8 -*-
class SolrDocument 

  include Blacklight::Solr::Document    
  
  field_semantics.merge!(    
                         :title => "title_display",
                         :author => "author_display",
                         :language => "language_facet",
                         :format => "format"
                         )



  # self.unique_key = 'id'
  
  # Email uses the semantic field mappings below to generate the body of an email.
  SolrDocument.use_extension( Blacklight::Solr::Document::Email )
  
  # SMS uses the semantic field mappings below to generate the body of an SMS email.
  SolrDocument.use_extension( Blacklight::Solr::Document::Sms )

  # DublinCore uses the semantic field mappings below to assemble an OAI-compliant Dublin Core document
  # Semantic mappings of solr stored fields. Fields may be multi or
  # single valued. See Blacklight::Solr::Document::ExtendableClassMethods#field_semantics
  # and Blacklight::Solr::Document#to_semantic_values
  # Recommendation: Use field names from Dublin Core
  use_extension( Blacklight::Solr::Document::DublinCore)   

  def manuscript_number
    return nil if self['collection_display'].nil?

    @manuscript_number ||= if self['collection_display'].include? 'Parker Medieval Manuscripts'
      manuscript_number = self.first('idno_display').to_s.sub('CCCC MS ', '')
      if (Float(manuscript_number) != nil rescue false)
        manuscript_number = manuscript_number.to_i
      end
      manuscript_number
    end
  end

  def manuscript_druid
    @manuscript_druid ||= if manuscript_number and PARKER_MASTER.has_key?(manuscript_number)
      PARKER_MASTER[manuscript_number]['druid'] 
    end
  end


end
