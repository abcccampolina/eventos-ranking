class CompeticaosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_competicao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /competicaos
  # GET /competicaos.json
  def index
    @competicaos = Competicao.all
  end

  # GET /competicaos/1
  # GET /competicaos/1.json
  def show; end

  # GET /competicaos/new
  def new
    @competicao = Competicao.new
  end

  # GET /competicaos/1/edit
  def edit
    @criterios_competicaos = CriteriosCompeticao.where(competicao_id: params[:id])
    @parametro_inscricaos = ParametroInscricao.where("competicao_id = #{params[:id]}")
  end

  # POST /competicaos
  # POST /competicaos.json
  def create
    @competicao = Competicao.new(competicao_params)

    respond_to do |format|
      if @competicao.save
        format.html { redirect_to @competicao, notice: 'Competicao was successfully created.' }
        format.json { render action: 'show', status: :created, location: @competicao }
      else
        format.html { render action: 'new' }
        format.json { render json: @competicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /competicaos/1
  # PATCH/PUT /competicaos/1.json
  def update
    respond_to do |format|
      if @competicao.update(competicao_params)
        format.html { redirect_to @competicao, notice: 'Competicao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @competicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competicaos/1
  # DELETE /competicaos/1.json
  def destroy
    @competicao.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competicao
      @competicao = Competicao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competicao_params
      params.require(:competicao).permit(:nome, :modalidade_id, :status, :competicao_desempate, :ajuste_nota, :desempate_em)
    end

    def sort_column
      Competicao.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
