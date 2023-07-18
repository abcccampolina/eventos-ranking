class ClusterCriteriosAvaliacaosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_cluster_criterios_avaliacao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /cluster_criterios_avaliacaos
  # GET /cluster_criterios_avaliacaos.json
  def index
    @cluster_criterios_avaliacaos = ClusterCriteriosAvaliacao.all
  end

  # GET /cluster_criterios_avaliacaos/1
  # GET /cluster_criterios_avaliacaos/1.json
  def show; end

  # GET /cluster_criterios_avaliacaos/new
  def new
    @cluster_criterios_avaliacao = ClusterCriteriosAvaliacao.new
  end

  # GET /cluster_criterios_avaliacaos/1/edit
  def edit; end

  # POST /cluster_criterios_avaliacaos
  # POST /cluster_criterios_avaliacaos.json
  def create
    @cluster_criterios_avaliacao = ClusterCriteriosAvaliacao.new(cluster_criterios_avaliacao_params)

    respond_to do |format|
      if @cluster_criterios_avaliacao.save
        format.html { redirect_to @cluster_criterios_avaliacao, notice: 'Cluster criterios avaliacao was successfully created.' }
        format.json { render action: 'show', status: :created, location: @cluster_criterios_avaliacao }
      else
        format.html { render action: 'new' }
        format.json { render json: @cluster_criterios_avaliacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cluster_criterios_avaliacaos/1
  # PATCH/PUT /cluster_criterios_avaliacaos/1.json
  def update
    respond_to do |format|
      if @cluster_criterios_avaliacao.update(cluster_criterios_avaliacao_params)
        format.html { redirect_to @cluster_criterios_avaliacao, notice: 'Cluster criterios avaliacao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @cluster_criterios_avaliacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cluster_criterios_avaliacaos/1
  # DELETE /cluster_criterios_avaliacaos/1.json
  def destroy
    @cluster_criterios_avaliacao.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cluster_criterios_avaliacao
      @cluster_criterios_avaliacao = ClusterCriteriosAvaliacao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def cluster_criterios_avaliacao_params
      params.require(:cluster_criterios_avaliacao).permit(:nome, :funcional)
    end

    def sort_column
      ClusterCriteriosAvaliacao.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
