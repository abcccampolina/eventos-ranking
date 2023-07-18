class EventosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_evento, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  skip_before_action :authenticate_user!
  
  # GET /eventos
  # GET /eventos.json
  def index
    @eventos = Evento.all
  end

  # GET /eventos/1
  # GET /eventos/1.json
  def show; end

  # GET /eventos/new
  def new
    @evento = Evento.new
    @evento.juris_templates&.build
  end

  # GET /eventos/1/edit
  def edit
    @competicaos_eventos = CompeticaosEvento.where(evento_id: params[:id])
    @juris_evento = CompeticaoJuri.where(competicaos_evento_id: @competicaos_eventos.map{|i| i.id}).group_by(&:user_id) #CompeticaoJuri.where(competicaos_evento_id: @competicaos_eventos.map{|i| i.id}).pluck(:user_id, :store_cluster_criterio_avaliacao_id).group_by(&:user_id)

  end

  # POST /eventos
  # POST /eventos.json
  def create
    @evento = Evento.new(evento_params)

    respond_to do |format|
      if @evento.save
        format.html { redirect_to @evento, notice: 'Evento was successfully created.' }
        format.json { render action: 'show', status: :created, location: @evento }
      else
        format.html { render action: 'new' }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /eventos/1
  # PATCH/PUT /eventos/1.json
  def update
    
    respond_to do |format|
      if @evento.update(evento_params)
        format.html { redirect_to @evento, notice: 'Evento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @evento.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_evento
      @evento = Evento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def evento_params
      params.require(:evento).permit(
        :nome, :dataInicio, :dataFim, :anoHipico, :data_avaliacao, :ativo, 
        :aceitar_inadiplentes, :max_animais_categoria, :min_animais_categoria, :range_1_1,  :range_1_2, :range_valor_1,  :range_2_1,  :range_2_2, :range_valor_2,
        :range_3_1,  :range_3_2, :range_valor_3, :range_4_1,  :range_4_2, :range_valor_4, :range_5_1,  :range_5_2, :range_valor_5, :range_6_1,  :range_6_2, :range_valor_6,
        :range_7_1,  :range_7_2, :range_valor_7, :range_8_1,  :range_8_2, :range_valor_8, :range_9_1,  :range_9_2, :range_valor_9, :range_10_1,  :range_10_2, :range_valor_10,
        :template, juris_templates: [:user_id, :cluster_id], user_ids: [])
      .merge(user_id: current_user.id)
    end

    def sort_column
      Evento.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
