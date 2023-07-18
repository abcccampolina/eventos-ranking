class InscritosCompeticaoController < ApplicationController
  skip_before_action :authenticate_user!
  
  def index
    
    @catalogo = Catalogo.where(id: params[:catalogo])
  
    @competidores = InscricaosCompeticao.where(
      competicaos_evento_id: @catalogo.pluck(:competicaos_evento_id),
      inscricao_id: @catalogo.map(&:inscricao_id)
    ).order(:nota_final, :nota_desempate, :observacao_final)
    @competicao = @catalogo.first.competicaos_evento.competicao

  end

  def change_cluster


    @catalogo = Catalogo.where(id: params[:catalogo].gsub('[', '').gsub(']','').split(",").map { |s| s.to_i })
    
    @competidores = InscricaosCompeticao.where(
      competicaos_evento_id: @catalogo.pluck(:competicaos_evento_id),
      inscricao_id: @catalogo.map(&:inscricao_id)
    )&.order(:nota_final, :nota_desempate, :observacao_final)
    @competicao = @catalogo.first.competicaos_evento.competicao

    @filter_cluster = params[:cluster]

    if @filter_cluster == "Morfologia"
      @competidores = @competidores.select {|ca| ca.inscricao.so_marcha == false  }
    end
    
    render inscritos_competicao_index_path
  end

end
