class AnimaisExpositorMailer < ApplicationMailer
  default from: "nao-responda@elevatech.com.br"

  def animais_expositor(inscricao)
    @inscricao = inscricao  

    url_confirmar_presenca = lista_confirmacao_url(inscricao.first&.expositor_id)
    qrcode = RQRCode::QRCode.new(url_confirmar_presenca)
    @img_qrcode = qrcode.as_png(
      bit_depth: 1,
      border_modules: 4,
      color_mode: ChunkyPNG::COLOR_GRAYSCALE,
      color: "black",
      file: nil,
      fill: "white",
      module_px_size: 6,
      resize_exactly_to: false,
      resize_gte_to: false,
      size: 200
    )
    #mail(to: "lucas.moreira@elevatech.com.br", subject: "Confirmação de Inscricão")
    mail(to: "adriana@campolina.org.br, tesouraria@campolina.org.br", subject: "Confirmação de Inscricão")
    #mail(to: "#{inscricao.first&.expositor&.email}, adriana@campolina.org.br, tesouraria@campolina.org.br", subject: "Confirmação de Inscricão")
  end
end
