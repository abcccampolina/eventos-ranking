class RankingController < ApplicationController
  skip_before_action :authenticate_user!
  
  # skip_before_action :authenticate_user!
  load_and_authorize_resource :ranking
  def index
    if params[:evento].present?
      $evento = Evento.find(params[:evento])
    end
    @ranking_id = Premio.joins("INNER JOIN inscricaos ON premios.inscricao_id =  inscricaos.id")
    .where("inscricaos.evento_id = #{$evento.id}")
    @rankings = Premio.where(id: @ranking_id.pluck(:id))
  end

  def ranking_animal
    if params[:evento].present?
      $evento = Evento.find(params[:evento])
    end
    @ranking_id = Premio.joins("INNER JOIN inscricaos ON premios.inscricao_id =  inscricaos.id")
    .where("inscricaos.evento_id = #{$evento.id}")
    @rankings = Premio.where(id: @ranking_id.pluck(:id))
    render "ranking/_animal"
  end

  def ranking_batida
    if params[:evento].present?
      $evento = Evento.find(params[:evento])
    end
    @ranking_id = Premio.joins("INNER JOIN inscricaos ON premios.inscricao_id =  inscricaos.id")
    .where("inscricaos.evento_id = #{$evento.id} and inscricaos.marcha like 'batida'")
    @rankings = Premio.where(id: @ranking_id.pluck(:id))
    render "ranking/_m_batida"
  end

  def ranking_picada
    if params[:evento].present?
      $evento = Evento.find(params[:evento])
    end
    @ranking_id = Premio.joins("INNER JOIN inscricaos ON premios.inscricao_id =  inscricaos.id")
    .where("inscricaos.evento_id = #{$evento.id} and inscricaos.marcha like 'picada'")
    @rankings = Premio.where(id: @ranking_id.pluck(:id))
    render "ranking/_m_picada"
  end

  def detalhe_ranking_criador
    if params[:evento].present?
      $evento = Evento.find(params[:evento])
    end
    @titulo = params[:criador]
    @ranking_id = Premio.joins("INNER JOIN inscricaos ON premios.inscricao_id =  inscricaos.id")
    .where("inscricaos.evento_id = #{$evento.id}")
    @rankings = Premio.where(id: @ranking_id.pluck(:id))
    @rankings = @rankings.where(criador: params[:criador])
    render "ranking/_detalhe"
  end

  def detalhe_ranking_expositor
    if params[:evento].present?
      $evento = Evento.find(params[:evento])
    end
    @titulo = params[:expositor]
    @ranking_id = Premio.joins("INNER JOIN inscricaos ON premios.inscricao_id =  inscricaos.id")
    .where("inscricaos.evento_id = #{$evento.id}")
    @rankings = Premio.where(id: @ranking_id.pluck(:id))
    @rankings = @rankings.where(expositor: params[:expositor])
    render "ranking/_detalhe"
  end

  def detalhe_ranking_animal
    if params[:evento].present?
      $evento = Evento.find(params[:evento])
    end
    @titulo = params[:animal]
    @ranking_id = Premio.joins("INNER JOIN inscricaos ON premios.inscricao_id =  inscricaos.id")
    .where("inscricaos.evento_id = #{$evento.id}")
    @rankings = Premio.where(id: @ranking_id.pluck(:id))
    @rankings = @rankings.where(nome_animal: params[:animal])
    render "ranking/_detalhe_animal"
  end

end
