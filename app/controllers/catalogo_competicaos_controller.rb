class CatalogoCompeticaosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_catalogo_competicao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /catalogo_competicaos
  # GET /catalogo_competicaos.json
  def index
    @catalogo_competicaos = CatalogoCompeticao.all
  end

  # GET /catalogo_competicaos/1
  # GET /catalogo_competicaos/1.json
  def show; end

  # GET /catalogo_competicaos/new
  def new
    @catalogo_competicao = CatalogoCompeticao.new
  end

  # GET /catalogo_competicaos/1/edit
  def edit; end

  # POST /catalogo_competicaos
  # POST /catalogo_competicaos.json
  def create
    @catalogo_competicao = CatalogoCompeticao.new(catalogo_competicao_params)

    respond_to do |format|
      if @catalogo_competicao.save
          format.html { redirect_to edit_competicaos_evento_path(catalogo_competicao_params[:competicaos_evento_id]), notice: 'Criado com Sucesso !' }
          format.json { render action: 'show', status: :created, location: @inscricaos_competicao }
      else
        format.html { render action: 'new' }
        format.json { render json: @catalogo_competicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catalogo_competicaos/1
  # PATCH/PUT /catalogo_competicaos/1.json
  def update
    respond_to do |format|
      if @catalogo_competicao.update(catalogo_competicao_params)
        format.html { redirect_to edit_competicaos_evento_path(catalogo_competicao_params[:competicaos_evento_id]), notice: 'Atualizado com Sucesso' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @catalogo_competicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogo_competicaos/1
  # DELETE /catalogo_competicaos/1.json
  def destroy
    @catalogo_competicao.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogo_competicao
      @catalogo_competicao = CatalogoCompeticao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalogo_competicao_params
      params.require(:catalogo_competicao).permit(:qtd_inscritos, :qtd_catalogos, :qtd_inscritos_fim, :competicaos_evento_id)
    end

    def sort_column
      CatalogoCompeticao.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
