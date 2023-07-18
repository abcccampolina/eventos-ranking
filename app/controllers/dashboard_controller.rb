class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def index
    competicoes = CompeticaosEvento.where(evento_id: $evento&.id)
    @catalogos = Catalogo.where(competicaos_evento_id: competicoes.ids)
    gon.test = "Warlery Oliveira"
    gon.rand = SecureRandom.hex

  end
end
