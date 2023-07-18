class CatalogoNomesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_catalogo_nome, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /catalogo_nomes
  # GET /catalogo_nomes.json
  def index
    @catalogo_nomes = CatalogoNome.all
  end

  # GET /catalogo_nomes/1
  # GET /catalogo_nomes/1.json
  def show; end

  # GET /catalogo_nomes/new
  def new
    @catalogo_nome = CatalogoNome.new
  end

  # GET /catalogo_nomes/1/edit
  def edit; end

  # POST /catalogo_nomes
  # POST /catalogo_nomes.json
  def create
    @catalogo_nome = CatalogoNome.new(catalogo_nome_params)

    respond_to do |format|
      if @catalogo_nome.save
        format.html { redirect_to edit_competicaos_evento_path(catalogo_nome_params[:competicaos_evento_id]), notice: 'Criado com Sucesso !' }
        format.json { render action: 'show', status: :created, location: @catalogo_nome }
      else
        format.html { render action: 'new' }
        format.json { render json: @catalogo_nome.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catalogo_nomes/1
  # PATCH/PUT /catalogo_nomes/1.json
  def update
    respond_to do |format|
      if @catalogo_nome.update(catalogo_nome_params)
        format.html { redirect_to edit_competicaos_evento_path(params[:catalogo_nome][:competicaos_evento_id]), notice: "Inscrições e Catálogo gerados com Sucesso !" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @catalogo_nome.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogo_nomes/1
  # DELETE /catalogo_nomes/1.json
  def destroy
    @catalogo_nome.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogo_nome
      @catalogo_nome = CatalogoNome.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalogo_nome_params
      params.require(:catalogo_nome).permit(:nome, :ordem_nome, :competicaos_evento_id)
    end

    def sort_column
      CatalogoNome.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
