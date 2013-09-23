class ZoomprController < ApplicationController
  def index
    begin
      @druid = !params[:druid].nil? ? params[:druid] : 'wz026zp2442'
      @image = !params[:image].nil? ? params[:image] : '001_023_V_TC_46'
      @image_width =  !params[:width].nil? ? params[:width] : '6142'
      @image_height =  !params[:height].nil? ? params[:height] : '9412'
      @ms = !params[:ms].nil? ? params[:ms] : 1

      if (Float(@ms) != nil rescue false)
        @ms = @ms.to_i
      end

      @folio = !params[:folio].nil? ? params[:folio] : 'f.+23+V'
      @sequence_num = !params[:sequence_num].nil? ? params[:sequence_num] : '50'
      @total_sequence_num = !params[:total_sequence_num].nil? ? params[:total_sequence_num] : '584'
      @headline = !params[:headline].nil? ? params[:headline] : 'PHN0cm9uZz5DYW1icmlkZ2UsIENvcnB1cyBDaHJpc3RpIENvbGxlZ2UsIFBhcmtlciBMaWJyYXJ5LCBDQ0NDIE1TIDE8L3N0cm9uZz48YnIgLz4NClZlbGx1bSwgMjEuNSB4IDE1LjUsIHh2PGJyIC8+DQpHYXJuZXJpdXMgb2YgU2FpbnQtVmljdG9yIE9TQSwgVGFidWxhZSBvbiBHcmVnb3J5IHRoZSBHcmVhdCwgTW9yYWxpYSBpbiBKb2IgZXQgYWwu'
    rescue => e
      @error = e.message
    end
  end
end
