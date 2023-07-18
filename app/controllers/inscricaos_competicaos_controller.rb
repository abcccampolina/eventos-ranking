class InscricaosCompeticaosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_inscricaos_competicao, only: [:show, :edit, :update, :destroy], except: [:nova_inscricao]
  load_and_authorize_resource
  skip_before_action :authenticate_user!
  
  # GET /inscricaos_competicaos
  # GET /inscricaos_competicaos.json
  def index
    @inscricaos_competicaos = InscricaosCompeticao.all
  end

  # GET /inscricaos_competicaos/1
  # GET /inscricaos_competicaos/1.json
  def show; end

  def buscar_casalamento
    @animal_mae = SrgAnimal.where(nome_completo: params[:nome_animal_mae]).where.not(pai: nil, data_nascimento: nil).order("ID DESC").first
    @animal_pai = SrgAnimal.where(nome_completo: params[:nome_animal_pai]).where.not(pai: nil, data_nascimento: nil).order("ID DESC").first

    @competicaos_evento_id = params[:filter][:competicaos_evento_id]
    @inscricaos = Inscricao.where(evento_id: $evento.id).order(:nome_animal)
    @inscricaos_competicao = InscricaosCompeticao.new
    render "inscricaos_competicaos/nova_inscricao"

  end

  def buscar_progenie
    @animal = SrgAnimal.where(nome_completo: params[:nome_animal]).where.not(pai: nil, data_nascimento: nil).order("ID DESC").first


    if @animal != nil
      @srg_criador = SrgPessoa.find(@animal.criador)
      @srg_proprietario = SrgPessoa.find(@animal.proprietario)

      @inscricao = Inscricao.new
      @criador = Pessoa.new
      @expositor = Pessoa.new
    else
      @animal = []
    end

    @competicaos_evento_id = params[:filter][:competicaos_evento_id]
    @inscricaos = Inscricao.where(evento_id: $evento.id).order(:nome_animal)
    @inscricaos_competicao = InscricaosCompeticao.new
    render "inscricaos_competicaos/nova_inscricao"
  end

  # GET /inscricaos_competicaos/new
  def new

    inscricao = Inscricao.find(params[:inscricao])
    competicaos = CompeticaosEvento.where("evento_id = #{inscricao.evento_id}")
    animal = SrgAnimal.where(["id = ?", "#{inscricao.srg_animal_id}"]).first
    
    @competicao = []
    #Validar em quais competições o animal se encaixa

    competicaos.each do |comp|
      competicao_evento = CompeticaosEvento.find(comp.id)
      parametros = ParametroInscricao.where(["competicao_id = #{comp.competicao_id}"])

      if parametros.present? 
        inscricaos = Inscricao.where(id: params[:inscricao])

        parametros.each do |parametro|

          #Atualiza os valores de acordo com a coluna da tabela que tem em parametros
          if parametro.tabela?
            if parametro.coluna_parametro == "faixa_etaria" || parametro.coluna_parametro == "pelagem"
              inscricaos = inscricaos.where("#{parametro.coluna_parametro} #{parametro.operador_parametro} ?", parametro.valor_parametro) rescue nil
            else
              animais = SrgAnimal.where("#{parametro.coluna_parametro} #{parametro.operador_parametro} '#{parametro.valor_parametro}' AND ID = ?", inscricaos.first.srg_animal_id) rescue nil
              inscricaos = inscricaos.where(srg_animal_id: animais.pluck(:id)) rescue nil
            end
          end

          #atualiza os valores de acordo com a coluna competicao antecessora e funsão
          if parametro.comp?
            inscricaos = nil
          end

          #Atualiza de acordo com a melhor indicação
          if parametro.melhor_indicacao?

            if parametro.melhor_indicacao_select == "cabeca"
              animais_melhor_indicacao = InscricaosCompeticao.where(evento_id: $evento.id, nota_final_melhor_cabeca: true)
              inscricaos = inscricaos.where(id: animais_melhor_indicacao.pluck(:inscricao_id))
            elsif parametro.melhor_indicacao_select == "aprumo"
              animais_melhor_indicacao = InscricaosCompeticao.where(evento_id: $evento.id, nota_final_melhor_aprumo: true)
              inscricaos = inscricaos.where(id: animais_melhor_indicacao.pluck(:inscricao_id))
            end

          end

          #Atualiza de acordo com o tipo de marcha
          if parametro.tipo_marcha?
            if parametro.tipo_marcha_select == "picada"
              inscricao_pelagem = Inscricao.where(evento_id: $evento.id, marcha: "picada")
              inscricaos = inscricaos.where(id: inscricao_pelagem.pluck(:id)) rescue nil
            elsif parametro.tipo_marcha_select == "batida"
              inscricao_pelagem = Inscricao.where(evento_id: $evento.id, marcha: "batida")
              inscricaos = inscricaos.where(id: inscricao_pelagem.pluck(:id)) rescue nil
            end
          end
        end
      end

      if inscricaos.present?
        @competicao += Competicao.where(id: comp.competicao_id)
      end
    end
    
    @inscricaos_competicao = InscricaosCompeticao.new
  end

  def nova_inscricao

    @inscricaos_competicao = InscricaosCompeticao.new
    @inscricaos = Inscricao.where(evento_id: $evento.id)

    render "inscricaos_competicaos/nova_inscricao"

  end

  # GET /inscricaos_competicaos/1/edit
  def edit; end

  # POST /inscricaos_competicaos
  # POST /inscricaos_competicaos.json
  def create

    if params[:inscricaos_competicao][:cadastro_admin].present?
      competicao_evento = CompeticaosEvento.find(params[:inscricaos_competicao][:competicaos_evento_id])
      @inscricaos_competicao = InscricaosCompeticao.new(inscricao_id: params[:inscricao_id_1], evento_id: params[:inscricaos_competicao][:evento_id], competicao_id: competicao_evento.competicao.id, competicaos_evento_id: competicao_evento.id, acasalamento_mae_id: params[:inscricaos_competicao][:acasalamento_mae] , acasalamento_pai_id: params[:inscricaos_competicao][:acasalamento_pai] , progenie_id: params[:inscricaos_competicao][:progenie], grupo_progenie: params[:inscricao_id_1], responsavel_expositor: params[:inscricaos_competicao][:responsavel_expositor])
      @inscricaos_competicao.save

      if params[:inscricao_id_2].present?
        @inscricaos_competicao = InscricaosCompeticao.new(inscricao_id: params[:inscricao_id_2], evento_id: params[:inscricaos_competicao][:evento_id], competicao_id: competicao_evento.competicao.id, competicaos_evento_id: competicao_evento.id, acasalamento_mae_id: params[:inscricaos_competicao][:acasalamento_mae] , acasalamento_pai_id: params[:inscricaos_competicao][:acasalamento_pai] , progenie_id: params[:inscricaos_competicao][:progenie], grupo_progenie: params[:inscricao_id_1], responsavel_expositor: params[:inscricaos_competicao][:responsavel_expositor])
        @inscricaos_competicao.save
      end
      if params[:inscricao_id_3].present?
        @inscricaos_competicao = InscricaosCompeticao.new(inscricao_id: params[:inscricao_id_3], evento_id: params[:inscricaos_competicao][:evento_id], competicao_id: competicao_evento.competicao.id, competicaos_evento_id: competicao_evento.id, acasalamento_mae_id: params[:inscricaos_competicao][:acasalamento_mae] , acasalamento_pai_id: params[:inscricaos_competicao][:acasalamento_pai] , progenie_id: params[:inscricaos_competicao][:progenie], grupo_progenie: params[:inscricao_id_1], responsavel_expositor: params[:inscricaos_competicao][:responsavel_expositor])
        @inscricaos_competicao.save
      end
      if params[:inscricao_id_4].present?
        @inscricaos_competicao = InscricaosCompeticao.new(inscricao_id: params[:inscricao_id_4], evento_id: params[:inscricaos_competicao][:evento_id], competicao_id: competicao_evento.competicao.id, competicaos_evento_id: competicao_evento.id, acasalamento_mae_id: params[:inscricaos_competicao][:acasalamento_mae] , acasalamento_pai_id: params[:inscricaos_competicao][:acasalamento_pai] , progenie_id: params[:inscricaos_competicao][:progenie], grupo_progenie: params[:inscricao_id_1], responsavel_expositor: params[:inscricaos_competicao][:responsavel_expositor])
        @inscricaos_competicao.save
      end
      if params[:inscricao_id_5].present?
        @inscricaos_competicao = InscricaosCompeticao.new(inscricao_id: params[:inscricao_id_5], evento_id: params[:inscricaos_competicao][:evento_id], competicao_id: competicao_evento.competicao.id, competicaos_evento_id: competicao_evento.id, acasalamento_mae_id: params[:inscricaos_competicao][:acasalamento_mae] ,  acasalamento_pai_id: params[:inscricaos_competicao][:acasalamento_pai] , progenie_id: params[:inscricaos_competicao][:progenie], grupo_progenie: params[:inscricao_id_1], responsavel_expositor: params[:inscricaos_competicao][:responsavel_expositor])
        @inscricaos_competicao.save
      end
      
      respond_to do |format|
        format.html { redirect_to edit_competicaos_evento_path(competicao_evento), notice: 'Inscricaos competicao was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inscricaos_competicao }
      end

    else
      params[:comp_ids]&.each do |i|
        competicao_evento = CompeticaosEvento.where("evento_id = #{params[:inscricaos_competicao][:evento_id]} and competicao_id = #{i}").first
        @inscricaos_competicao = InscricaosCompeticao.new(inscricao_id: params[:inscricaos_competicao][:inscricao_id], evento_id: params[:inscricaos_competicao][:evento_id], competicao_id: i, competicaos_evento_id: competicao_evento.id)
        @inscricaos_competicao.save
      end

      Thread.new do
       Inscricao.where(id: params[:inscricaos_competicao][:inscricao_id]).includes(:expositor).sort_by {|i| i.expositor_id }.group_by {|i| i.expositor.nome.parameterize }.each do |_expositor, inscricoes| 
          AnimaisExpositorMailer.animais_expositor(inscricoes).deliver! if inscricoes.first.expositor.email.present?
        end
      end

      respond_to do |format|
        format.html { redirect_to inscricaos_path, notice: 'Inscricaos competicao was successfully created.' }
        format.json { render action: 'show', status: :created, location: @inscricaos_competicao }
      end
    end
  end

  # PATCH/PUT /inscricaos_competicaos/1
  # PATCH/PUT /inscricaos_competicaos/1.json
  def update
    respond_to do |format|
      if @inscricaos_competicao.update(inscricaos_competicao_params)
        format.html { redirect_to @inscricaos_competicao, notice: 'Inscricaos competicao was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @inscricaos_competicao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inscricaos_competicaos/1
  # DELETE /inscricaos_competicaos/1.json
  def destroy
    @inscricaos_competicao.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_inscricaos_competicao
      @inscricaos_competicao = InscricaosCompeticao.find(params[:id]) rescue nil
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def inscricaos_competicao_params
      params.require(:inscricaos_competicao).permit(:inscricao_id_1, :inscricao_id_2, :inscricao_id_3, :inscricao_id_4, :inscricao_id_5, :evento_id, :comp_ids)
    end

    def sort_column
      InscricaosCompeticao.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
