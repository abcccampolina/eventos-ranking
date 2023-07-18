class SumulaController < ApplicationController
  def index
    if params[:competicaos_evento_id].present?
      @catalogos = CompeticaosEvento.find(params[:competicaos_evento_id]).catalogos
    else
      @catalogos = Catalogo.all
    end
    
    url_notas = Link.shorten(inscritos_competicao_index_url(catalogo_encrypted: encrypt(@catalogos.pluck(:id))))

    qrcode = RQRCode::QRCode.new(url_notas)
    @svg_qrcode = qrcode.as_svg(
      offset: 0,
      color: '000',
      shape_rendering: 'crispEdges',
      module_size: 3,
      standalone: true
    )

    respond_to do |format|
      format.html do 
        render 'sumula/sumula.pdf.erb', template: 'sumula/sumula', layout: "layouts/sumula"
      end
      format.json
      format.pdf do 
        render template: 'sumula/sumula', layout: "layouts/sumula", pdf: 'sumula', page_size: 'A4'
      end
    end

  end
end
