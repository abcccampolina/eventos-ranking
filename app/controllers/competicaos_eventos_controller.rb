class CompeticaosEventosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_competicaos_evento, only: [:show, :edit, :update, :destroy], except: [:gerar_inscritos]
  include ApplicationHelper
  load_and_authorize_resource

  # GET /competicaos_eventos
  # GET /competicaos_eventos.json
  def index
    @competicaos_eventos = $evento.competicaos_eventos # CompeticaosEvento.where(evento: $evento)
  end

  # GET /competicaos_eventos/1
  # GET /competicaos_eventos/1.json
  def show; end

  # GET /competicaos_eventos/new
  def new
    @competicaos_evento = CompeticaosEvento.new
  end

  def gerar_inscritos
    competicao_evento = CompeticaosEvento.find(params[:competicaos_evento_id])
    parametros = ParametroInscricao.where(["competicao_id = #{competicao_evento.competicao_id}"])
      
    if parametros.present?
      @inscricaos = Inscricao.where(evento_id: $evento.id)
      parametros.each do |parametro|
        #Atualiza os valores de acordo com a coluna da tabela que tem em parametros
        if parametro.tabela?
          if parametro.coluna_parametro == "faixa_etaria" || parametro.coluna_parametro == "pelagem"
            @inscricaos = @inscricaos.where("#{parametro.coluna_parametro} #{parametro.operador_parametro} ?", parametro.valor_parametro) rescue nil
          else
            animais = SrgAnimal.where("#{parametro.coluna_parametro} #{parametro.operador_parametro} '#{parametro.valor_parametro}'") rescue nil
            @inscricaos = @inscricaos.where(srg_animal_id: animais.pluck(:id)) rescue nil
          end
        end

        #atualiza os valores de acordo com a coluna competicao antecessora e funsão
        if parametro.comp?
          if  parametro.fusao_competicao_antecessora_id.present?
            campeoes = {}
            limite = (parametro.comp_posicao_fim - parametro.comp_posicao_inicio) + 1 
            inscritos_competicao = InscricaosCompeticao.where(competicao_id: parametro.competicao_antecessora, evento_id: $evento.id)
            inscritos_competicao.each do |insc|
              camepao =  InscricaosCompeticao.where(competicao_id: parametro.fusao_competicao_antecessora_id, evento_id: $evento.id, inscricao_id: insc.inscricao_id)
              nota = (camepao.nota_final + insc.nota_final)
              campeoes.add({ins.inscricao_id => nota})
              campeoes.sort_by {|k, v| v}.reverse!
              campeoes = campeoes.limit(limite).offset(parametro.comp_posicao_inicio - 1)
              @inscricaos = @inscricaos.where(id: campeoes.keys) rescue nil
            end

          else
            
            if competicao_evento.competicao.modalidade.nome == "Grande Competição Castrado de Sela"
              @competicao_evento_antecessora = CompeticaosEvento.find_by(competicao_id: parametro.competicao_antecessora, evento_id: $evento.id)
              campeoes_proxima_fase = Premio.where(competicaos_evento_id: @competicao_evento_antecessora.id, posto: "campeão marcha categoria").pluck(:inscricao_id)
              campeoes_proxima_fase << Premio.where(competicaos_evento_id: @competicao_evento_antecessora.id, posto: "reservado marcha categoria").pluck(:inscricao_id) if @inscricaos.count <= 150
            else
              @competicao_evento_antecessora = CompeticaosEvento.find_by(competicao_id: parametro.competicao_antecessora, evento_id: $evento.id)
              campeoes_proxima_fase = Premio.where(competicaos_evento_id: @competicao_evento_antecessora.id, posto: "campeão marcha categoria").pluck(:inscricao_id)
              campeoes_proxima_fase << Premio.where(competicaos_evento_id: @competicao_evento_antecessora.id, posto: "reservado marcha categoria").pluck(:inscricao_id) if @inscricaos.count <= 150
              campeoes_proxima_fase << Premio.where(competicaos_evento_id: @competicao_evento_antecessora.id, posto: "campeão convencional").pluck(:inscricao_id)
              campeoes_proxima_fase << Premio.where(competicaos_evento_id: @competicao_evento_antecessora.id, posto: "reservado convencional").pluck(:inscricao_id) if @inscricaos.count <= 150
              campeoes_proxima_fase << Premio.where(competicaos_evento_id: @competicao_evento_antecessora.id, posto: "campeão morfologia categoria").pluck(:inscricao_id)
              campeoes_proxima_fase << Premio.where(competicaos_evento_id: @competicao_evento_antecessora.id, posto: "reservado morfologia categoria").pluck(:inscricao_id) if @inscricaos.count <= 150
            end

            campeoes_proxima_fase.flatten!

            @inscricaos = @inscricaos.where(id: campeoes_proxima_fase) rescue nil

          end
        end
        #Atualiza de acordo com a melhor indicação
        if parametro.melhor_indicacao_select?
          if parametro.melhor_indicacao_select == "cabeca"
            animais_melhor_indicacao = InscricaosCompeticao.where(evento_id: $evento.id, nota_final_melhor_cabeca: true)
            @inscricaos = @inscricaos.where(id: animais_melhor_indicacao.pluck(:inscricao_id))
          elsif parametro.melhor_indicacao_select == "aprumo"
            animais_melhor_indicacao = InscricaosCompeticao.where(evento_id: $evento.id, nota_final_melhor_aprumo: true)
            @inscricaos = @inscricaos.where(id: animais_melhor_indicacao.pluck(:inscricao_id))
          end
        end
        
        #Atualiza de acordo com o tipo de marcha
        if parametro.tipo_marcha_select?
          if parametro.tipo_marcha_select == "picada"
            inscricao_pelagem = Inscricao.where(evento_id: $evento.id, marcha: "picada")
            @inscricaos = @inscricaos.where(id: inscricao_pelagem.pluck(:id))
          elsif parametro.tipo_marcha_select == "batida"
            inscricao_pelagem = Inscricao.where(evento_id: $evento.id, marcha: "batida")
            @inscricaos = @inscricaos.where(id: inscricao_pelagem.pluck(:id))
          end
        end
      end
    #Fim da verificação dos parametros de inscrição
      if @inscricaos.present?
        @inscricaos.each do |insc|
          check_inscricao = InscricaosCompeticao.find_by(inscricao_id: insc.id, evento_id: $evento.id, competicao_id: competicao_evento.competicao_id, competicaos_evento_id: competicao_evento.id)
          posto = InscricaosCompeticao.find_by(inscricao_id: insc.id, competicao_id: @competicao_evento_antecessora.competicao_id) rescue nil
          posto_json = Premio.where("inscricao_id = #{insc.id} and competicaos_evento_id = #{@competicao_evento_antecessora.id} and (posto like 'campeão marcha categoria' or posto like 'campeão convencional' or posto like 'reservado marcha categoria' or posto like 'reservado convencional' or posto like 'reservado morfologia categoria' or posto like 'campeão morfologia categoria')") rescue nil
          posto_arr = posto_json.to_a.map{|a| a.attributes.select{|k,v| %W(posto inscricao_campeao_id).include? k }}

          if !check_inscricao.present?
            @new_inscricaos_competicao = InscricaosCompeticao.new(inscricao_id: insc.id, evento_id: $evento.id, competicao_id: competicao_evento.competicao_id, competicaos_evento_id: competicao_evento.id, campeao_anterior_json: posto_arr )
            @new_inscricaos_competicao.save

          else
            check_inscricao.update(campeao_anterior_json: posto_arr)
          end
        end

        catalogo(params[:competicaos_evento_id])
        redirect_to edit_competicaos_evento_path(params[:competicaos_evento_id]), notice: "Inscrições e Catálogo gerados com Sucesso !" 
      else
        catalogo(params[:competicaos_evento_id])
        redirect_to edit_competicaos_evento_path(params[:competicaos_evento_id]), notice: "Catálogo gerado com sucesso, porém não há novas inscrições a serem geradas !" 
      end
    else
      catalogo(params[:competicaos_evento_id])
      redirect_to edit_competicaos_evento_path(params[:competicaos_evento_id]), notice: "Catálogo gerado com sucesso, porém não há novas inscrições a serem geradas !" 
    end
  end

  def catalogo(competicao_evento_id)
    gerar_catalogo(competicao_evento_id)
  end


  # GET /competicaos_eventos/1/edit
  def edit
    @competicao_juris = CompeticaoJuri.where(competicaos_evento_id: params[:id])
    @catalogo_competicaos = CatalogoCompeticao.where(competicaos_evento_id: params[:id])
    @catalogo_nomes = CatalogoNome.where(competicaos_evento_id: params[:id])
    @inscricaos_competicaos = InscricaosCompeticao.where(competicaos_evento_id: params[:id])

    #@criterios_competicaos = CriteriosCompeticao.where(competicao_id: params[:competicao_id])
  end

  # POST /competicaos_eventos
  # POST /competicaos_eventos.json
  def create
    @competicaos_evento = CompeticaosEvento.new(competicaos_evento_params)

    respond_to do |format|
      if @competicaos_evento.save
        format.html { redirect_to @competicaos_evento, notice: 'Competicaos evento was successfully created.' }
        format.json { render action: 'show', status: :created, location: @competicaos_evento }
      else
        format.html { render action: 'new' }
        format.json { render json: @competicaos_evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /competicaos_eventos/1
  # PATCH/PUT /competicaos_eventos/1.json
  def update
    respond_to do |format|
      if @competicaos_evento.update(competicaos_evento_params)
        format.html { redirect_to @competicaos_evento, notice: 'Competicaos evento was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @competicaos_evento.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /competicaos_eventos/1
  # DELETE /competicaos_eventos/1.json
  def destroy
    @competicaos_evento.destroy
    render json: { ok: true }
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competicaos_evento
      @competicaos_evento = CompeticaosEvento.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competicaos_evento_params
      params.require(:competicaos_evento).permit(:competicao_id, :evento_id)
    end

    def sort_column
      CompeticaosEvento.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
