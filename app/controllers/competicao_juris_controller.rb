class CompeticaoJurisController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_competicao_juri, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /competicao_juris
  # GET /competicao_juris.json
  def index
    @competicao_juris = CompeticaoJuri.all
  end

  # GET /competicao_juris/1
  # GET /competicao_juris/1.json
  def show; end

  # GET /competicao_juris/new
  def new
    @competicao_juri = CompeticaoJuri.new
  end

  # GET /competicao_juris/1/edit
  def edit; end

  # POST /competicao_juris
  # POST /competicao_juris.json
  def create
    

    #Necessidade de Ajustar colocando o + na view
    permissao = CompeticaoJuri.where(competicaos_evento_id: params[:competicao_juri][:competicaos_evento_id], user_id: params[:competicao_juri][:user_id] )
    

    permissao_criterios = []
    permissao_criterios << permissao.map{|p| p.store_cluster_criterio_avaliacao_id}
    permissao_criterios << params[:competicao_juri][:cluster_criterios_avaliacao_id].to_i
    permissao_criterios.flatten!

    CompeticaoJuri.where(competicaos_evento_id: params[:competicao_juri][:competicaos_evento_id], user_id: params[:competicao_juri][:user_id] ).delete_all

    @competicao_juri = CompeticaoJuri.new(
      competicaos_evento_id: params[:competicao_juri][:competicaos_evento_id],
      user_id: params[:competicao_juri][:user_id],
      store_cluster_criterio_avaliacao_id: permissao_criterios,
      cluster_criterios_avaliacao_id: params[:competicao_juri][:cluster_criterios_avaliacao_id],
      juri_desempate: params[:competicao_juri][:juri_desempate]
      )

    respond_to do |format|
      if @competicao_juri.save
        format.html { redirect_to @competicao_juri, notice: 'Competicao juri was successfully created.' }
        format.json { render action: 'show', status: :created, location: @competicao_juri }
      else
        format.html { render action: 'new' }
        format.json { render json: @competicao_juri.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /competicao_juris/1
  # PATCH/PUT /competicao_juris/1.json
  def update
    respond_to do |format|
      if @competicao_juri.update(competicao_juri_params)
        format.html { redirect_to @competicao_juri, notice: 'Competicao juri was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @competicao_juri.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competicao_juris/1
  # DELETE /competicao_juris/1.json
  def destroy
    # @competicao_juri.destroy
    # render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competicao_juri
      @competicao_juri = CompeticaoJuri.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competicao_juri_params
      params.require(:competicao_juri).permit(:competicaos_evento_id, :user_id, :cluster_criterios_avaliacao_id, :juri_desempate)
    end

    def sort_column
      CompeticaoJuri.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
