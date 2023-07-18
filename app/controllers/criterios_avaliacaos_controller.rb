class CriteriosAvaliacaosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_criterios_avaliacao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /criterios_avaliacaos
  # GET /criterios_avaliacaos.json
  def index
    @criterios_avaliacaos = CriteriosAvaliacao.all
  end

  # GET /criterios_avaliacaos/1
  # GET /criterios_avaliacaos/1.json
  def show; end

  # GET /criterios_avaliacaos/new
  def new
    @criterios_avaliacao = CriteriosAvaliacao.new
  end

  # GET /criterios_avaliacaos/1/edit
  def edit; end

  # POST /criterios_avaliacaos
  # POST /criterios_avaliacaos.json
  def create
    @criterios_avaliacao = CriteriosAvaliacao.new(criterios_avaliacao_params)

    respond_to do |format|
      if @criterios_avaliacao.save
        format.html { redirect_to @criterios_avaliacao, notice: 'Criterios avaliacao was successfully created.' }
        format.json { render action: 'show', status: :created, location: @criterios_avaliacao }
      else
        format.html { render action: 'new' }
        format.json { render json: @criterios_avaliacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criterios_avaliacaos/1
  # PATCH/PUT /criterios_avaliacaos/1.json
  def update
    respond_to do |format|
      if @criterios_avaliacao.update(criterios_avaliacao_params)
        format.html { redirect_to @criterios_avaliacao, notice: 'Criterios avaliacao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @criterios_avaliacao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criterios_avaliacaos/1
  # DELETE /criterios_avaliacaos/1.json
  def destroy
    @criterios_avaliacao.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criterios_avaliacao
      @criterios_avaliacao = CriteriosAvaliacao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criterios_avaliacao_params
      params.require(:criterios_avaliacao).permit(:nome, :cluster_criterios_avaliacao_id)
    end

    def sort_column
      CriteriosAvaliacao.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
