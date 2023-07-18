class CriteriosCompeticaosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_criterios_competicao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /criterios_competicaos
  # GET /criterios_competicaos.json
  def index
    @criterios_competicaos = CriteriosCompeticao.all
  end

  # GET /criterios_competicaos/1
  # GET /criterios_competicaos/1.json
  def show; end

  # GET /criterios_competicaos/new
  def new
    @criterios_competicao = CriteriosCompeticao.new
  end

  # GET /criterios_competicaos/1/edit
  def edit; end

  # POST /criterios_competicaos
  # POST /criterios_competicaos.json
  def create
    @criterios_competicao = CriteriosCompeticao.new(criterios_competicao_params)

    respond_to do |format|
      if @criterios_competicao.save
        format.html { redirect_to edit_competicao_path(params[:criterios_competicao][:competicao_id]), notice: 'Criterios competicao was successfully created.' }
        format.json { render action: 'show', status: :created, location: @criterios_competicao }
      else
        format.html { render action: 'new' }
        format.json { render json: @criterios_competicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /criterios_competicaos/1
  # PATCH/PUT /criterios_competicaos/1.json
  def update
    respond_to do |format|
      if @criterios_competicao.update(criterios_competicao_params)
        format.html { redirect_to @criterios_competicao, notice: 'Criterios competicao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @criterios_competicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /criterios_competicaos/1
  # DELETE /criterios_competicaos/1.json
  def destroy
    @criterios_competicao.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_criterios_competicao
      @criterios_competicao = CriteriosCompeticao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def criterios_competicao_params
      params.require(:criterios_competicao).permit(:competicao_id, :criterios_avaliacao_id, :peso, :metodo)
    end

    def sort_column
      CriteriosCompeticao.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
