# -*- encoding : utf-8 -*-
require 'blacklight/catalog'

class CatalogController < ApplicationController  

  include Blacklight::Catalog

  configure_blacklight do |config|
    ## Default parameters to send to solr for all search-like requests. See also SolrHelper#solr_search_params
    config.default_solr_params = { 
      :qt => 'standard',
      :q => '*:*',
      :rows => 10,
      :facet => true,
      :'facet.mincount' => 1
    }


    ## Default parameters to send on single-document requests to Solr. These settings are the Blackligt defaults (see SolrHelper#solr_doc_params) or 
    ## parameters included in the Blacklight-jetty document requestHandler.
    #
    #config.default_document_solr_params = {
    #  :qt => 'document',
    #  ## These are hard-coded in the blacklight 'document' requestHandler
    #  # :fl => '*',
    #  # :rows => 1
    #  # :q => '{!raw f=id v=$id}' 
    #}

    # solr field configuration for search results/index views
    config.index.show_link = 'qualified_idno_display'
    config.index.record_display_type = 'qualified_idno_display'
    config.index.thumbnail_method = :render_manuscript_thumbnail
    config.index.partials = [:index_header,:links,:thumbnail, :index]

    # solr field configuration for document/show views
    config.show.html_title = 'qualified_idno_display'
    config.show.heading = 'qualified_idno_display'
    config.show.display_type = 'format'
    config.show.partials = [:show_header, :show_thumbnail, :show, :flipbook, :image_list]

    # solr fields that will be treated as facets by the blacklight application
    #   The ordering of the field names is the order of the display
    #
    # Setting a limit will trigger Blacklight's 'more' facet values link.
    # * If left unset, then all facet values returned by solr will be displayed.
    # * If set to an integer, then "f.somefield.facet.limit" will be added to
    # solr request, with actual solr request being +1 your configured limit --
    # you configure the number of items you actually want _displayed_ in a page.    
    # * If set to 'true', then no additional parameters will be sent to solr,
    # but any 'sniffed' request limit parameters will be used for paging, with
    # paging at requested limit -1. Can sniff from facet.limit or 
    # f.specific_field.facet.limit solr request params. This 'true' config
    # can be used if you set limits in :default_solr_params, or as defaults
    # on the solr side in the request handler itself. Request handler defaults
    # sniffing requires solr requests to be made with "echoParams=all", for
    # app code to actually have it echo'd back to see it.  
    #
    # :show may be set to false if you don't want the facet to be drawn in the 
    # facet bar

    config.add_facet_field 'collection_facet', :label => 'Collection', :single => true
    config.add_facet_field 'country_facet', :label => 'Country'
    config.add_facet_field 'institution_facet', :label => 'Institution', :limit => 20 
    config.add_facet_field 'settlement_facet', :label => 'Settlement', :limit => true 
    config.add_facet_field 'repository_facet', :label => 'Repository', :single => true 
    config.add_facet_field 'textLang_facet', :label => 'Language' 
    config.add_facet_field 'material_facet', :label => 'Material'  
    config.add_facet_field 'origDate_facet', :label => 'Date of Origin'  
    config.add_facet_field 'origPlace_facet', :label => 'Place of Origin'  


    # Have BL send all facet field names to Solr, which has been the default
    # previously. Simply remove these lines if you'd rather use Solr request
    # handler defaults, or have no facets.
    config.add_facet_fields_to_solr_request!

   # solr fields to be displayed in the index (search results) view
    #   The ordering of the field names is the order of the display 
    config.add_index_field 'collection_display', :label  => 'Collection:'
    config.add_index_field 'idno_display'      , :label  => 'Manuscript Identifier:'
    config.add_index_field 'msTitle_display'   , :label  => 'Manuscript Title:'
    config.add_index_field 'origDate_display'  , :label  => 'Origin Date:'
    config.add_index_field 'origPlace_display' , :label  => 'Origin Place:'
    config.add_index_field 'material_display'  , :label  => 'Material:'
    config.add_index_field 'textLang_display'  , :label  => 'Language:'


    # solr fields to be displayed in the show (single result) view
    #   The ordering of the field names is the order of the display 
    config.add_show_field 'collection_display',    :label  => 'Collection:'
    config.add_show_field 'institution_display',   :label  => 'Institution:'
    config.add_show_field 'repository_display',    :label  => 'Repository:'
    config.add_show_field 'settlement_display',    :label  => 'Settlement:'
    config.add_show_field 'country_display',       :label  => 'Country:'
    config.add_show_field 'region_display',        :label  => 'Region:'
    config.add_show_field 'idno_display',          :label  => 'Manuscript Identifier:'
    config.add_show_field 'altIdentifier_display', :label  => 'Alternate Identifier:'
    config.add_show_field 'msTitle_display',       :label  => 'Manuscript Title:'
    config.add_show_field 'origDate_display',      :label  => 'Origin Date:'
    config.add_show_field 'origPlace_display"',    :label  => 'Origin Place:'
    config.add_show_field 'material_display',      :label  => 'Material:'
    config.add_show_field 'textLang_display',      :label  => 'Language:'
    config.add_show_field 'dimensions_display',    :label  => 'Dimensions:'
    config.add_show_field 'provenance_display',    :label  => 'Provenance:'
    config.add_show_field 'description_url',       :label  => 'Description URL:'
    config.add_show_field 'image_url',             :label  => 'Image URL:'

  end

end 
