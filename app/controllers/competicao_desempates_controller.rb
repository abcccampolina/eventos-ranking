class CompeticaoDesempatesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_competicao_desempate, only: [:show, :destroy]
  load_and_authorize_resource
  
  # GET /competicao_desempates
  # GET /competicao_desempates.json
  def index
    @competicao_desempates = CompeticaoDesempate.all
  end

  # GET /competicao_desempates/1
  # GET /competicao_desempates/1.json
  def show; end

  # GET /competicao_desempates/new
  def new
    @competicao_desempate = CompeticaoDesempate.new

    competicaos_evento_id = CompeticaosEvento.where("evento_id = #{$evento.id} and competicao_id = #{params[:competicao_id]}").first
    @competicaojuris = CompeticaoJuri.where("competicaos_evento_id = #{competicaos_evento_id.id}") rescue nil
    @competicaojuris&.each do |juri|
      competicao = CompeticaoDesempate.where(competicao_juri_id: juri.id).first
      if competicao.present?
        instance_variable_set("@competicao_desempate#{juri.user.id}", competicao)
      else
        instance_variable_set("@competicao_desempate#{juri.user.id}", CompeticaoDesempate.new)
      end
    end

    @criterios_competicao = CriteriosCompeticao.where(competicao_id: params[:competicao_id])
    @criterios = CriteriosAvaliacao.where(id: @criterios_competicao.map { |i| i['criterios_avaliacao_id'] })
    @clusters = ClusterCriteriosAvaliacao.where(id: @criterios.map { |i| i['cluster_criterios_avaliacao_id'] })

  end

  # GET /competicao_desempates/1/edit
  def edit
    competicaos_evento_id = CompeticaosEvento.where("evento_id = #{$evento.id} and competicao_id = #{params[:competicao_id]}").first
    @competicaojuris = CompeticaoJuri.where("competicaos_evento_id = #{competicaos_evento_id.id}") rescue nil
    @competicaojuris&.each do |juri|
      competicao = CompeticaoDesempate.where(competicao_juri_id: juri.id).first
      if competicao.present?
        instance_variable_set("@competicao_desempate#{juri.user.id}", competicao)
      else
        instance_variable_set("@competicao_desempate#{juri.user.id}", CompeticaoDesempate.new)
      end
    end

    @criterios_competicao = CriteriosCompeticao.where(competicao_id: params[:competicao_id])
    @criterios = CriteriosAvaliacao.where(id: @criterios_competicao.map { |i| i['criterios_avaliacao_id'] })
    @clusters = ClusterCriteriosAvaliacao.where(id: @criterios.map { |i| i['cluster_criterios_avaliacao_id'] })
  end

  # POST /competicao_desempates
  # POST /competicao_desempates.json
  def create

    competicaos_evento_id = CompeticaosEvento.where("evento_id = #{params[:competicao_desempate][:evento_id]} and competicao_id = #{params[:competicao_desempate][:competicao_id]}").first
    competicao_juri_id = CompeticaoJuri.where("competicaos_evento_id = #{competicaos_evento_id.id} and user_id = #{params[:competicao_desempate][:juri_id]}").first

    params[:nota].each do |p|
      criterio_competicao = nil
      criterio_competicao = CriteriosCompeticao.where("criterios_avaliacao_id = #{p[0]} and competicao_id = #{params[:competicao_desempate][:competicao_id]}").first
      if criterio_competicao.present?
        @competicao_desempate = CompeticaoDesempate.new(competicaos_evento_id: competicaos_evento_id.id, competicao_juri_id: competicao_juri_id.id, inscricao_id: params[:competicao_desempate][:inscricao_id], criterios_competicao_id: criterio_competicao&.id, nota: p[1])

        @competicao_desempate.save
      end
    end

    return true, "Nota Atualizada com sucesso"
  end

  # PATCH/PUT /competicao_desempates/1
  # PATCH/PUT /competicao_desempates/1.json
  def update

    competicaos_evento_id = CompeticaosEvento.where("evento_id = #{params[:competicao_desempate][:evento_id]} and competicao_id = #{params[:competicao_desempate][:competicao_id]}").first
    competicao_juri_id = CompeticaoJuri.where("competicaos_evento_id = #{competicaos_evento_id.id} and user_id = #{params[:competicao_desempate][:juri_id]}").first
    CompeticaoDesempate.where("competicao_juri_id = #{competicao_juri_id.id} and inscricao_id = #{params[:competicao_desempate][:inscricao_id]} and competicaos_evento_id = #{competicaos_evento_id.id}").delete_all rescue nil

    params[:nota].each do |p|
      criterio_competicao = nil
      criterio_competicao = CriteriosCompeticao.where("criterios_avaliacao_id = #{p[0]} and competicao_id = #{params[:competicao_desempate][:competicao_id]}").first
      if criterio_competicao.present?
        @competicao_desempate = CompeticaoDesempate.new(competicaos_evento_id: competicaos_evento_id.id, competicao_juri_id: competicao_juri_id.id, inscricao_id: params[:competicao_desempate][:inscricao_id], criterios_competicao_id: criterio_competicao&.id, nota: p[1])
        @competicao_desempate.save
      end
    end


    competicaos_evento_origin = CompeticaosEvento.where("evento_id = #{params[:competicao_desempate][:evento_id]} and competicao_id = #{params[:competicao_desempate][:comp]}").first
    criterios = CriteriosCompeticao.where(competicao_id: params[:competicao_desempate][:competicao_id])
    nota_desempate = 0
    criterios.each do |criterio|
      notas  = CompeticaoDesempate.where("inscricao_id = #{params[:competicao_desempate][:inscricao_id]} and criterios_competicao_id = #{criterio.id}")
      nota_desempate += notas.map{|i| i&.nota&.to_f || 0}.sum
    end
    inscrito_nota_desempate = InscricaosCompeticao.where("inscricao_id = #{params[:competicao_desempate][:inscricao_id]} and competicaos_evento_id = #{competicaos_evento_origin.id}").first
    inscrito_nota_desempate.update(nota_desempate: nota_desempate)

    return true, "Nota Atualizada com sucesso"
  end

  # DELETE /competicao_desempates/1
  # DELETE /competicao_desempates/1.json
  def destroy
    @competicao_desempate.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competicao_desempate
      @competicao_desempate = CompeticaoDesempate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competicao_desempate_params
      #params.require(:competicao_desempate).permit(:competicaos_evento_id, :inscricao_id, :competicao_juri_id, :nota, :criterios_competicao_id)
    end

    def sort_column
      CompeticaoDesempate.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
