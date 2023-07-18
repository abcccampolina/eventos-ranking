class ModalidadesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_modalidade, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  
  # GET /modalidades
  # GET /modalidades.json
  def index
    @modalidades = Modalidade.all
  end

  # GET /modalidades/1
  # GET /modalidades/1.json
  def show; end

  # GET /modalidades/new
  def new
    @modalidade = Modalidade.new
  end

  # GET /modalidades/1/edit
  def edit; end

  # POST /modalidades
  # POST /modalidades.json
  def create
    @modalidade = Modalidade.new(modalidade_params)

    respond_to do |format|
      if @modalidade.save
        format.html { redirect_to @modalidade, notice: 'Modalidade was successfully created.' }
        format.json { render action: 'show', status: :created, location: @modalidade }
      else
        format.html { render action: 'new' }
        format.json { render json: @modalidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /modalidades/1
  # PATCH/PUT /modalidades/1.json
  def update
    respond_to do |format|
      if @modalidade.update(modalidade_params)
        format.html { redirect_to @modalidade, notice: 'Modalidade was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @modalidade.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /modalidades/1
  # DELETE /modalidades/1.json
  def destroy
    @modalidade.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modalidade
      @modalidade = Modalidade.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def modalidade_params
      params.require(:modalidade).permit(:nome)
    end

    def sort_column
      Modalidade.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
