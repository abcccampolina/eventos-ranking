class CatalogosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_catalogo, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  include ApplicationHelper

  
  # GET /catalogos
  # GET /catalogos.json
  def index

    competicao_evento = CompeticaosEvento.where(evento_id: $evento.id)

    if params[:competicaos_evento_id].present?
      @catalogos = Catalogo.joins(:competicaos_evento)
      .where(competicaos_evento_id: params[:competicaos_evento_id], numero_colete_progenie: nil)
      .where(numero_colete_progenie: nil).order('competicaos_eventos.ordem', 'numero_colete')
      .includes(inscricao: [{srg_animal: [:animal_pai, :animal_mae]}, :expositor, :criador])
      .group_by { |c|c&.nome_catalogo&.parameterize }

      @catalogos_progenie = Catalogo.joins(:competicaos_evento)
      .where(competicaos_evento_id: params[:competicaos_evento_id])
      .where.not(numero_colete_progenie: nil).order('competicaos_eventos.ordem', 'numero_colete')
    else
      @catalogos = Catalogo.joins(:competicaos_evento)
      .where(numero_colete_progenie: nil)
      .where(competicaos_evento_id: competicao_evento.ids)
      .order('competicaos_eventos.ordem', 'numero_colete')
      .includes(inscricao: [{srg_animal: [:animal_pai, :animal_mae]}, :expositor, :criador])
      .group_by { |c| c&.nome_catalogo&.parameterize }
      #@catalogos_progenie = Catalogo.joins(:competicaos_evento).where.not(numero_colete_progenie: nil).order('competicaos_eventos.ordem', 'numero_colete')
    end

    respond_to do |format|
      format.html do 
        render 'catalogos/catalogo.pdf.erb',
        template: 'catalogos/catalogo',
        layout: "layouts/catalogo"
      end
      format.json
      format.pdf do 
        render template: 'catalogos/catalogo',
        layout: "layouts/catalogo",
        pdf: 'catalogo',
        page_size: 'A3',
        footer: { right: 'Página [page] de [topage]' }
      end
    end
  end

  # GET /catalogos/1
  # GET /catalogos/1.json
  def show; end

  # GET /catalogos/new
  def new
    @catalogo = Catalogo.new
  end

  #gerar categoria e catalogo do evento
  def gerar
    
    competicaos_evento = CompeticaosEvento.where(evento_id: $evento)
    count_inscritos = Inscricao.where(evento_id: $evento)&.count

    # competicaos_evento.each do |competicaos| 
    #   num_competidores = InscricaosCompeticao.where(competicaos_evento_id: competicaos.id)&.count
    #   num_competidores_convencional = InscricaosCompeticao.joins('INNER JOIN inscricaos on inscricaos_competicaos.inscricao_id = inscricaos.id')
    #   .where(competicaos_evento_id:competicaos.id).where.not('inscricaos.so_marcha')&.count

    #   num_competidores_somarcha = InscricaosCompeticao.joins('INNER JOIN inscricaos on inscricaos_competicaos.inscricao_id = inscricaos.id')
    #   .where(competicaos_evento_id:competicaos.id).where('inscricaos.so_marcha')&.count

      #atentar a divisão por 1 animal, deve existir pelo menos 1 comp.
      #qtde_campeonatos = (num_competidores&.to_f / $evento.max_animais_categoria&.to_f)&.ceil

    #     if num_competidores_convencional < $evento.range_1_1
    #       qtde_campeonatos = 0
    #     end

    #     if num_competidores_convencional > $evento.range_1_1 && num_competidores_convencional <= $evento.range_1_2
    #       qtde_campeonatos = $evento.range_valor_1
    #     end


    # if qtde_campeonatos > 0
    #   animais_por_comp = (num_competidores_convencional&.to_f / qtde_campeonatos&.to_f)&.round rescue nil
    # end

    # if qtde_campeonatos > 0
    #   if animais_por_comp&.to_f > ($evento.max_animais_categoria&.to_f - (num_competidores_somarcha&.to_f / qtde_campeonatos&.to_f)&.ceil&.to_f)&.to_f && animais_por_comp&.to_f != $evento.max_animais_categoria&.to_f
    #     qtde_campeonatos += 1
    #   end
    # end

    #   if animais_por_comp.present?
    #     if competicaos.competicao.categoria_unica == true
    #       CatalogoCompeticao.where(competicaos_evento_id: competicaos.id).delete_all
    #       CatalogoCompeticao.create(
    #         qtd_inscritos: 1,
    #         qtd_inscritos_fim: num_competidores,
    #         qtd_catalogos: 1,
    #         competicaos_evento_id: competicaos.id
    #       )
    #     else
    #       CatalogoCompeticao.where(competicaos_evento_id: competicaos.id).delete_all
    #       CatalogoCompeticao.create(
    #         qtd_inscritos: 1,
    #         qtd_inscritos_fim: num_competidores,
    #         qtd_catalogos: qtde_campeonatos,
    #         competicaos_evento_id: competicaos.id
    #       )
    #     end
    #   end
    # end
    
    gerar_catalogo(nil)
    redirect_to relatorio_index_path, notice: "Catálogo Gerado com sucesso"
  end

  # GET /catalogos/1/edit
  def edit; end

  # POST /catalogos
  # POST /catalogos.json
  def create
    @catalogo = Catalogo.new(catalogo_params)

    respond_to do |format|
      if @catalogo.save
        format.html { redirect_to @catalogo, notice: 'Catalogo was successfully created.' }
        format.json { render action: 'show', status: :created, location: @catalogo }
      else
        format.html { render action: 'new' }
        format.json { render json: @catalogo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /catalogos/1
  # PATCH/PUT /catalogos/1.json
  def update
    respond_to do |format|
      if @catalogo.update(catalogo_params)
        format.html { redirect_to @catalogo, notice: 'Catalogo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @catalogo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /catalogos/1
  # DELETE /catalogos/1.json
  def destroy
    @catalogo.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_catalogo
      @catalogo = Catalogo.find(params[:id]) if params[:id]
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def catalogo_params
      params.require(:catalogo).permit(:inscricao_id, :nome_catalogo, :competicao_evento_id)
    end

    def sort_column
      Catalogo.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
