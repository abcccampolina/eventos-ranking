class ParametroInscricaosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_parametro_inscricao, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /parametro_inscricaos
  # GET /parametro_inscricaos.json
  def index
    @parametro_inscricaos = ParametroInscricao.all
  end

  # GET /parametro_inscricaos/1
  # GET /parametro_inscricaos/1.json
  def show; end

  # GET /parametro_inscricaos/new
  def new
    @parametro_inscricao = ParametroInscricao.new
  end

  # GET /parametro_inscricaos/1/edit
  def edit; end

  # POST /parametro_inscricaos
  # POST /parametro_inscricaos.json
  def create
    # @parametro_inscricao = ParametroInscricao.new(nome: params.dig(:parametro_inscricao, :nome), competicao_id: params.dig(:parametro_inscricao, :competicao_id), coluna_parametro: params.dig(:parametro_inscricao, :coluna_parametro), operador_parametro: params.dig(:parametro_inscricao, :operador_parametro), valor_parametro: params.dig(:parametro_inscricao, :valor_parametro), comp_posicao_inicio: params.dig(:parametro_inscricao, :comp_posicao_inicio), comp_posicao_fim: params.dig(:parametro_inscricao, :comp_posicao_fim), comp_or_table: params.dig(:comp_or_table), competicao_antecessora: params.dig(:parametro_inscricao, :competicao_antecessora))
    @parametro_inscricao = ParametroInscricao.new(parametro_inscricao_params)
    respond_to do |format|
      if @parametro_inscricao.save
        format.html { redirect_to edit_competicao_path(params[:parametro_inscricao][:competicao_id]), notice: 'Parâmetro inscrição Criado' }
        format.json { render action: 'show', status: :created, location: @parametro_inscricao }
      else
        format.html { render action: 'new' }
        format.json { render json: @parametro_inscricao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parametro_inscricaos/1
  # PATCH/PUT /parametro_inscricaos/1.json
  def update
    respond_to do |format|
      # if @parametro_inscricao.update(nome: params.dig(:parametro_inscricao, :nome), competicao_id: params.dig(:parametro_inscricao, :competicao_id), coluna_parametro: params.dig(:parametro_inscricao, :coluna_parametro), operador_parametro: params.dig(:parametro_inscricao, :operador_parametro), valor_parametro: params.dig(:parametro_inscricao, :valor_parametro), comp_posicao_inicio: params.dig(:parametro_inscricao, :comp_posicao_inicio), comp_posicao_fim: params.dig(:parametro_inscricao, :comp_posicao_fim), comp_or_table: params.dig(:comp_or_table), competicao_antecessora: params.dig(:parametro_inscricao, :competicao_antecessora))
      if @parametro_inscricao.update(parametro_inscricao_params)
        format.html { redirect_to @parametro_inscricao, notice: 'Parametro inscricao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @parametro_inscricao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parametro_inscricaos/1
  # DELETE /parametro_inscricaos/1.json
  def destroy
    @parametro_inscricao.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parametro_inscricao
      @parametro_inscricao = ParametroInscricao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parametro_inscricao_params
      params.require(:parametro_inscricao).permit(:nome, :competicao_id, :coluna_parametro,
        :operador_parametro, :valor_parametro, :comp_posicao_inicio, :comp_posicao_fim,
        :competicao_antecessora, :melhor_indicacao_select, :tipo_marcha_select,
        :comp_or_table, :fusao_competicao_antecessora_id, :operador_fusao,
        :criterio_competicao_antecessora
      )
    end

    def sort_column
      ParametroInscricao.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
