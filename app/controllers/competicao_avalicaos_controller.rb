class CompeticaoAvalicaosController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_action :set_competicao_avalicao, only: [:show, :destroy], except: [:ajuste_nota_marchador, :pdf_ajuste_nota_marchador, :ajuste_nota]
  before_action :set_data_form, only: [:new, :edit]
  before_action :set_notas, only: [:update, :create]
  load_and_authorize_resource
  
  # GET /competicao_avalicaos
  # GET /competicao_avalicaos.json
  def index
    @competicao_avalicaos = CompeticaoAvalicao.all
  end

  # GET /competicao_avalicaos/1
  # GET /competicao_avalicaos/1.json
  def show; end

  # GET /competicao_avalicaos/new
  def new; end   # --- Movido para set_data_form ---

  # GET /competicao_avalicaos/1/edit
  def edit; end  # --- Movido para set_data_form ---

  #Ajustar e imprimir nota do campeão / reservado da raça
  def ajuste_nota

    #Descobre quem são os campeões
    campeoes = InscricaosCompeticao.where(competicaos_evento_id: params[:competicao_evento_id]).where('campeao_anterior_json @> ?', [{posto: 'campeão convencional'}].to_json).order(:nota_final, :nota_desempate)
    primeiro_campeao = campeoes.first
    criterios = CriteriosCompeticao.where(competicao_id: params[:competicao_id])

    #Descobre quem são os reservados
    if primeiro_campeao.present?
      reservados = InscricaosCompeticao.where(competicaos_evento_id: params[:competicao_evento_id]).where('campeao_anterior_json @> ?', [{posto: 'reservado convencional'}].to_json).where('campeao_anterior_json @> ?', [{inscricao_campeao_id: primeiro_campeao.campeao_anterior_json.first.values.second}].to_json)
      reservados += InscricaosCompeticao.where(competicaos_evento_id: params[:competicao_evento_id]).where.not(id: primeiro_campeao.id).where('campeao_anterior_json @> ?', [{posto: 'campeão convencional'}].to_json)
      reservados = reservados.sort_by { |reserva| [reserva.nota_final, reserva.nota_desempate] }
      resto_competidores = InscricaosCompeticao.where(competicaos_evento_id: params[:competicao_evento_id]).where.not(id:reservados).where.not(id:campeoes)
    end

    #ajuste de nota do campeão
    competicaos_evento_id = CompeticaosEvento.where("evento_id = #{$evento.id} and competicao_id = #{params[:competicao_id]}").first
    catalogo = Catalogo.find_by(inscricao_id: primeiro_campeao.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)
    inscritos_catalogo = Catalogo.where(competicaos_evento_id: competicaos_evento_id.id, catalogo_nome_id: catalogo.catalogo_nome_id, inscricao_id: campeoes.map{ |m| m.inscricao_id})
    DimPdfGrandeCampeao.where(competicaos_evento_id: competicaos_evento_id.id).delete_all

    campeoes.each do |campeao|
      inscrito_nota_final = InscricaosCompeticao.find_by(inscricao_id: campeao.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)
      @nota_final = 0
      melhor_cabeca_final = false
      observacao_final = nil
      aprumo_final = false
      
      criterios.each do |criterio|
        @classificado = 1
        nota_classificacao = 1
        classificaos = CompeticaoAvalicao.where(criterios_competicao_id: criterio.id, evento_id: $evento.id, catalogo_id: inscritos_catalogo.map{|p| p.id}).where.not(nota: 0).where.not(nota: nil).group('inscricao_id')
        classificaos_sum = classificaos.sum('nota')

        # if criterio.criterios_avaliacao.nome == "Nota Marcha"
        #   classificaos_sum.merge!(classificaos.maximum('nota')) { |key, important, default| [important, default].flatten }
        #   classificaos_sum.merge!(classificaos.minimum('nota')) { |key, important, default| [important, default].flatten }
        #   classificaos_sum = classificaos_sum.map{|k,e| [k, e.each_cons(3).map{|pair| pair[0] - pair[1] - pair[2]}]}.to_h
        # end

        classificaos_sum.merge!(classificaos.sum('nota_juri_desempate')) { |key, important, default| [important, default].flatten }
        classificaos_sum = classificaos_sum.sort_by{| k, v | v}

        classificaos_sum.each do |inscricao, nota|

          aval = CompeticaoAvalicao.where(inscricao_id: inscricao, criterios_competicao_id: criterio.id, evento_id: $evento.id)
          aval_final_desempate = InscricaosCompeticao.find_by(inscricao_id: inscricao, competicaos_evento_id: competicaos_evento_id.id)
          nota_desempate = 99

          if criterio.criterios_avaliacao.nome == "Nota Morfologia" && inscrito_nota_final.competicao.desempate_em == 'morfologia'
            aval_final_desempate.update(nota_desempate: @classificado)
            nota_desempate = @classificado
          elsif criterio.criterios_avaliacao.nome == "Nota Marcha" && inscrito_nota_final.competicao.desempate_em == 'marcha'
            aval_final_desempate.update(nota_desempate: @classificado)
            nota_desempate = @classificado
          end
          
          aval.each do |update_aval|
            if aval_final_desempate.observacao_final&.present? && aval_final_desempate.observacao_final != "asterisco"
              update_aval.update classificacao: 999
              nota_classificacao = 999
            else
              update_aval.update classificacao: @classificado
              nota_classificacao = @classificado
            end
          end

          DimPdfGrandeCampeao.where(catalogo_id: aval.first.catalogo.id, posto_competicao: 'campeão', competicaos_evento_id: competicaos_evento_id.id, criterios_competicao_id: criterio.id).delete_all
          DimPdfGrandeCampeao.create(
            competicaos_evento_id: competicaos_evento_id.id,
            posto_competicao: 'campeão',
            nota: nota.first,
            animal: aval_final_desempate.inscricao.nome_animal,
            colete: aval.first.catalogo.numero_colete,
            catalogo_id: aval.first.catalogo.id,
            criterios_competicao_id: criterio.id,
            classificacao: nota_classificacao,
            nota_juri_desempate: nota_desempate
          )

          if aval_final_desempate.observacao_final&.present? && aval_final_desempate.observacao_final != "asterisco"

          else
            @classificado += 1
          end


        end
        #fim do classificacao

        notas  = CompeticaoAvalicao.where(inscricao_id: campeao.inscricao_id, criterios_competicao_id: criterio.id, evento_id: $evento.id).where.not(nota: 0).where.not(nota: nil)   
        classe = DescriptiveStatistics::Stats.new(notas.map{|i| i&.classificacao || nil})

        @nota_final += classe&.mode || 0

        stats_observacao = DescriptiveStatistics::Stats.new(notas.map{|i| i&.ocorrencia || nil})
        observacao_final = stats_observacao.mode rescue nil


        if aprumo_final == false
          aprumo_final = stats_aprumo.mode rescue false
        end
        stats_melhor_cabeca = DescriptiveStatistics::Stats.new(notas.map{|i| i&.melhor_cabeca || false})
        if melhor_cabeca_final == false
          melhor_cabeca_final = stats_melhor_cabeca.mode rescue false
        end

      end
      #Fim do criterio

      if observacao_final&.present? && observacao_final != 'asterisco'
          @nota_final = 9999
      end


      bool_empate = false
      if inscrito_nota_final.competicao.desempate_em == 'prova_funcional'
        inscrito_nota_final.update(nota_final: @nota_final,nota_desempate: (tempo_executado + criterio_funcional_tempo), empate: bool_empate, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      else
        inscrito_nota_final.update(nota_final: @nota_final, empate: bool_empate, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      end
    end
    #Fim do campeão

    #ajuste de nota dos reservados
    reservados.each do |reserva|
      @nota_final = 0
      melhor_cabeca_final = false
      observacao_final = nil
      aprumo_final = false

      competicaos_evento_id = CompeticaosEvento.where("evento_id = #{$evento.id} and competicao_id = #{params[:competicao_id]}").first
      catalogo = Catalogo.find_by(inscricao_id: reserva.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)
      inscritos_catalogo = Catalogo.where(competicaos_evento_id: competicaos_evento_id.id, catalogo_nome_id: catalogo.catalogo_nome_id, inscricao_id: reservados.map{|p| p.inscricao_id})
      inscrito_nota_final = InscricaosCompeticao.find_by(inscricao_id: reserva.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)

      criterios.each do |criterio|
        @classificado = 1
        nota_classificacao = 1
        classificaos = CompeticaoAvalicao.where(criterios_competicao_id: criterio.id, evento_id: $evento.id, catalogo_id: inscritos_catalogo.map{|p| p.id}).where.not(nota: 0).where.not(nota: nil).group('inscricao_id')
        classificaos_sum = classificaos.sum('nota')

        # if criterio.criterios_avaliacao.nome == "Nota Marcha"
        #   classificaos_sum.merge!(classificaos.maximum('nota')) { |key, important, default| [important, default].flatten }
        #   classificaos_sum.merge!(classificaos.minimum('nota')) { |key, important, default| [important, default].flatten }
        #   classificaos_sum = classificaos_sum.map{|k,e| [k, e.each_cons(3).map{|pair| pair[0] - pair[1] - pair[2]}]}.to_h
        # end

        classificaos_sum.merge!(classificaos.sum('nota_juri_desempate')) { |key, important, default| [important, default].flatten }
        classificaos_sum = classificaos_sum.sort_by{| k, v | v}  

        classificaos_sum.each do |inscricao,nota|
          aval = CompeticaoAvalicao.where(inscricao_id: inscricao, criterios_competicao_id: criterio.id, evento_id: $evento.id)
          aval_final_desempate = InscricaosCompeticao.find_by(inscricao_id: inscricao, competicaos_evento_id: competicaos_evento_id.id)
          nota_desempate = 99
          if criterio.criterios_avaliacao.nome == "Nota Morfologia" && inscrito_nota_final.competicao.desempate_em == 'morfologia'
            aval_final_desempate.update(nota_desempate: @classificado)
            nota_desempate = @classificado
          elsif criterio.criterios_avaliacao.nome == "Nota Marcha" && inscrito_nota_final.competicao.desempate_em == 'marcha'
            aval_final_desempate.update(nota_desempate: @classificado)
            nota_desempate = @classificado
          end

          aval.each do |update_aval|
            if aval_final_desempate.observacao_final&.present? && aval_final_desempate.observacao_final != "asterisco"
              update_aval.update classificacao: 999
              nota_classificacao = 999
            else
              update_aval.update classificacao: @classificado
              nota_classificacao = @classificado
            end
          end

          DimPdfGrandeCampeao.where(catalogo_id: aval.first.catalogo.id, posto_competicao: 'reservado', competicaos_evento_id: competicaos_evento_id.id, criterios_competicao_id: criterio.id).delete_all
          DimPdfGrandeCampeao.create(
            competicaos_evento_id: competicaos_evento_id.id,
            posto_competicao: 'reservado',
            nota: nota.first,
            animal: aval_final_desempate.inscricao.nome_animal,
            colete: aval.first&.catalogo&.numero_colete,
            catalogo_id: aval.first.catalogo.id,
            criterios_competicao_id: criterio.id,
            classificacao: nota_classificacao,
            nota_juri_desempate: nota_desempate
          )

          if aval_final_desempate.observacao_final&.present? && aval_final_desempate.observacao_final != "asterisco"

          else
            @classificado += 1
          end

        end

        notas  = CompeticaoAvalicao.where(inscricao_id: reserva.inscricao_id,criterios_competicao_id: criterio.id, evento_id: $evento.id).where.not(nota: 0).where.not(nota: nil)

        classe = DescriptiveStatistics::Stats.new(notas.map{|i| i&.classificacao || nil})
        @nota_final += classe&.mode || 0

        stats_observacao = DescriptiveStatistics::Stats.new(notas.map{|i| i&.ocorrencia || nil})
        observacao_final = stats_observacao.mode rescue nil

        stats_aprumo = DescriptiveStatistics::Stats.new(notas.map{|i| i&.aprumacao || nil})
        if aprumo_final == false
          aprumo_final = stats_aprumo.mode rescue false
        end
        stats_melhor_cabeca = DescriptiveStatistics::Stats.new(notas.map{|i| i&.melhor_cabeca || false})
        if melhor_cabeca_final == false
          melhor_cabeca_final = stats_melhor_cabeca.mode rescue false
        end

      end

      if observacao_final&.present? && observacao_final != 'asterisco'
        @nota_final = 9999
      end
  
      bool_empate = false
      
      if inscrito_nota_final.competicao.desempate_em == 'prova_funcional'
        inscrito_nota_final.update(nota_final: @nota_final,nota_desempate: (tempo_executado + criterio_funcional_tempo), empate: bool_empate, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      else
        inscrito_nota_final.update(nota_final: @nota_final, empate: bool_empate, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      end
    end

    #ajuste de nota dos restante
    resto_competidores.each do |resto|
      @nota_final = 0
      melhor_cabeca_final = false
      observacao_final = nil
      aprumo_final = false

      competicaos_evento_id = CompeticaosEvento.where("evento_id = #{$evento.id} and competicao_id = #{params[:competicao_id]}").first
      catalogo = Catalogo.find_by(inscricao_id: resto.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)
      inscritos_catalogo = Catalogo.where(competicaos_evento_id: competicaos_evento_id.id, catalogo_nome_id: catalogo.catalogo_nome_id, inscricao_id: resto_competidores.map{|p| p.inscricao_id})
      inscrito_nota_final = InscricaosCompeticao.find_by(inscricao_id: resto.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)

      criterios.each do |criterio|
        @classificado = reservados.count + 2 
        classificaos = CompeticaoAvalicao.where(criterios_competicao_id: criterio.id, evento_id: $evento.id, catalogo_id: inscritos_catalogo.map{|p| p.id}).where.not(nota: 0).where.not(nota: nil).group('inscricao_id')
        classificaos_sum = classificaos.sum('nota')
        # if criterio.criterios_avaliacao.nome == "Nota Marcha"
        #   classificaos_sum.merge!(classificaos.maximum('nota')) { |key, important, default| [important, default].flatten }
        #   classificaos_sum.merge!(classificaos.minimum('nota')) { |key, important, default| [important, default].flatten }
        #   classificaos_sum = classificaos_sum.map{|k,e| [k, e.each_cons(3).map{|pair| pair[0] - pair[1] - pair[2]}]}.to_h
        # end
        
        classificaos_sum.merge!(classificaos.sum('nota_juri_desempate')) { |key, important, default| [important, default].flatten }
        classificaos_sum = classificaos_sum.sort_by{| k, v | v}  

        classificaos_sum.each do |inscricao,nota|
          aval = CompeticaoAvalicao.where(inscricao_id: inscricao, criterios_competicao_id: criterio.id, evento_id: $evento.id)
          aval_final_desempate = InscricaosCompeticao.find_by(inscricao_id: inscricao, competicaos_evento_id: competicaos_evento_id.id)
          

          if criterio.criterios_avaliacao.nome == "Nota Morfologia" && inscrito_nota_final.competicao.desempate_em == 'morfologia'
            aval_final_desempate.update(nota_desempate: @classificado)
          elsif criterio.criterios_avaliacao.nome == "Nota Marcha" && inscrito_nota_final.competicao.desempate_em == 'marcha'
            aval_final_desempate.update(nota_desempate: @classificado)
          end

          aval.each do |update_aval|
            if aval_final_desempate.observacao_final&.present? && aval_final_desempate.observacao_final != "asterisco"
              update_aval.update classificacao: 999
              nota = 999
            else
              update_aval.update classificacao: @classificado
              nota = @classificado
            end
          end

           if aval_final_desempate.observacao_final&.present? && aval_final_desempate.observacao_final != "asterisco"

          else
            @classificado += 1
          end
          
        end

        notas  = CompeticaoAvalicao.where(inscricao_id: resto.inscricao_id,criterios_competicao_id: criterio.id, evento_id: $evento.id).where.not(nota: 0).where.not(nota: nil)
        
        classe = DescriptiveStatistics::Stats.new(notas.map{|i| i&.classificacao || nil})
        @nota_final += classe&.mode || 0

        stats_observacao = DescriptiveStatistics::Stats.new(notas.map{|i| i&.ocorrencia || nil})
        observacao_final = stats_observacao.mode rescue nil


        stats_aprumo = DescriptiveStatistics::Stats.new(notas.map{|i| i&.aprumacao || nil})
        if aprumo_final == false
          aprumo_final = stats_aprumo.mode rescue false
        end
        stats_melhor_cabeca = DescriptiveStatistics::Stats.new(notas.map{|i| i&.melhor_cabeca || false})
        if melhor_cabeca_final == false
          melhor_cabeca_final = stats_melhor_cabeca.mode rescue false
        end

      end

      if observacao_final&.present? && observacao_final != 'asterisco'
        @nota_final = 9999
      end
  
      bool_empate = false
      
      pdf_nota_final = DimPdfGrandeCampeao.where(inscricao_id: resto.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)
      if inscrito_nota_final.competicao.desempate_em == 'prova_funcional'
        inscrito_nota_final.update(nota_final: @nota_final,nota_desempate: (tempo_executado + criterio_funcional_tempo), empate: bool_empate, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      else
        inscrito_nota_final.update(nota_final: @nota_final, empate: bool_empate, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      end
    end
  
      @nota_morfologia = 0
      
      inscritos_catalogo_total = Catalogo.where(competicaos_evento_id: competicaos_evento_id.id, catalogo_nome_id: catalogo.catalogo_nome_id)
      competidores = InscricaosCompeticao.where(competicaos_evento_id: inscritos_catalogo_total.map{|m| m.competicaos_evento_id})
      competidores = competidores.where(inscricao_id: inscritos_catalogo_total.map{|m| m.inscricao_id}).order(:nota_final, :nota_desempate)
      
      position = 1
      competidores.each do |competidor|
        if position == 1 && !competidor.observacao_final&.present?
          @campeao = competidor.id
          competidor.update posto: 'campeão', campeao: @campeao
        elsif position == 2 && !competidor.observacao_final&.present?
          competidor.update posto: 'reservado', campeao: @campeao
        else
          competidor.update posto: '', campeao: ''
        end
        position += 1
      end


     pdf_grande_campeao =  DimPdfGrandeCampeao.where(catalogo_id: inscritos_catalogo_total.ids, posto_competicao: 'campeão').group('catalogo_id')
     pdf_grande_campeao_sum = pdf_grande_campeao.sum('classificacao')
     pdf_grande_campeao_sum.merge!(pdf_grande_campeao.sum('nota_juri_desempate')) { |key, important, default| [important, default].flatten }
     pdf_grande_campeao_sum = pdf_grande_campeao_sum.sort_by{| k, v | v}

     position = 1

     pdf_grande_campeao_sum.each do |cat_id, nota|
      pdf_atualizar = DimPdfGrandeCampeao.where(catalogo_id: cat_id)
      if position == 1 
          pdf_atualizar.update posto_final: 'campeão', classificacao_final: position
          
          catalogo = Catalogo.find(cat_id)
          aval = InscricaosCompeticao.find_by(inscricao_id: catalogo.inscricao, competicaos_evento_id: competicaos_evento_id.id)

          elsif position == 2 
            pdf_atualizar.update posto_final: '', classificacao_final: position
          else
            pdf_atualizar.update posto_final: '', classificacao_final: position
        end
        position += 1
      end


     pdf_grande_campeao =  DimPdfGrandeCampeao.where(catalogo_id: inscritos_catalogo_total.ids, posto_competicao: 'reservado').group('catalogo_id')
     pdf_grande_campeao_sum = pdf_grande_campeao.sum('classificacao')
     pdf_grande_campeao_sum.merge!(pdf_grande_campeao.sum('nota_juri_desempate')) { |key, important, default| [important, default].flatten }

     pdf_grande_campeao_sum = pdf_grande_campeao_sum.sort_by{| k, v | v}

     position = 1
     pdf_grande_campeao_sum.each do |cat_id, nota|
      pdf_atualizar = DimPdfGrandeCampeao.where(catalogo_id: cat_id)
        if position == 1 
          pdf_atualizar.update posto_final: 'reservado', classificacao_final: position

          catalogo = Catalogo.find(cat_id)
          aval = InscricaosCompeticao.find_by(inscricao_id: catalogo.inscricao, competicaos_evento_id: competicaos_evento_id.id)

        elsif position == 2 
          pdf_atualizar.update posto_final: '', classificacao_final: position
        else
          pdf_atualizar.update posto_final: '', classificacao_final: position
        end
        position += 1
      end

      
    @pdf_campeao = DimPdfGrandeCampeao.where(competicaos_evento_id: competicaos_evento_id.id, posto_competicao: 'campeão')
    @pdf_reservado = DimPdfGrandeCampeao.where(competicaos_evento_id: competicaos_evento_id.id, posto_competicao: 'reservado')
      
    respond_to do |format|
      format.html do 
        render 'competicao_avalicaos/pdf_ajuste_campeao.pdf.erb', template: 'competicao_avalicaos/pdf_ajuste_campeao', layout: "layouts/catalogo"
      end
      format.json
      format.pdf do 
        render template: 'competicao_avalicaos/pdf_ajuste_campeao', layout: "layouts/catalogo", pdf: 'catalogo', page_size: 'A3'
      end
    end
  end

  #Imprimir os resultados parciais
  def imprimir_parcial

    GC.start

    competicaos_evento_id = CompeticaosEvento.find(params[:competicao_evento_id])
    inscritos_catalogo = Catalogo.where(id: params[:catalogo])
    #Atribuir a classificação de cada animal no cluster de avaliação - Acasalamento
    if  competicaos_evento_id.competicao.modalidade.nome == "Competição Progênie"
      inscritos_catalogo.group_by{|c| c.numero_colete_progenie}.each do |progenie, insc_catalogo|
          @nota_final = 0
          melhor_cabeca_final = false
          observacao_final = nil
          aprumo_final = false
          @inscrito_nota_final = InscricaosCompeticao.find_by(inscricao_id: insc_catalogo.first.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)
          criterios = CriteriosCompeticao.where(competicao_id: competicaos_evento_id.competicao_id)
          @nota_final = 0
          criterios.each do |criterio|

            classificaos = CompeticaoAvalicao.joins('INNER JOIN catalogos on competicao_avalicaos.catalogo_id = catalogos.id').where(criterios_competicao_id: criterio.id, evento_id: $evento.id, catalogo_id: inscritos_catalogo.map{|p| p.id}).where.not(nota: 0).where.not(nota: nil).group('numero_colete_progenie')
            classificaos_sum = classificaos.sum('nota')
            classificaos_sum.merge!(classificaos.sum('nota_juri_desempate')) { |key, important, default| [important, default].flatten }
            classificaos_sum = classificaos_sum.sort_by{| k, v | v}
            classificado = 1
          
            classificaos_sum.each do |colete_progenie, nota|

              inscricaos = Catalogo.where(id: params[:catalogo], numero_colete_progenie: colete_progenie)
              inscricaos.each do |inscricao|
                aval = CompeticaoAvalicao.where(inscricao_id: inscricao.inscricao_id, criterios_competicao_id: criterio.id)
                aval_final_desempate = InscricaosCompeticao.find_by(inscricao_id: inscricao.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)
                if criterio.criterios_avaliacao.nome == "Nota Morfologia"
                  aval_final_desempate.update(nota_desempate: classificado)
                  if @inscrito_nota_final.competicao.desempate_em == 'morfologia'
                    aval_final_desempate.update(nota_desempate: classificado)
                  end
                  Premio.where("inscricaos_competicao_id = #{aval_final_desempate.id} and posto like '%conjunto progênie de morfologia%'").delete_all
                  qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: aval_final_desempate.inscricao.pelagem, marcha: aval_final_desempate.inscricao.marcha).count
                  if classificado == 1 && (!aval_final_desempate.observacao_final.present? || aval_final_desempate.observacao_final == 'asterisco')
                    @campeao = aval_final_desempate.id
                    Premio.create posto: 'campeão conjunto progênie de morfologia', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id , nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 15 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 15 * 1, pontuacao: 15 * 1, animais_julgados: qtde_competidores 
                  elsif classificado == 2 && (!aval_final_desempate.observacao_final.present? || aval_final_desempate.observacao_final == 'asterisco')
                    Premio.create posto: 'reservado conjunto progênie de morfologia', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id , nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 10 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 10 * 1, pontuacao: 10 * 1, animais_julgados: qtde_competidores
                  end
                elsif criterio.criterios_avaliacao.nome == "Nota Marcha"
                  if @inscrito_nota_final.competicao.desempate_em == 'marcha'
                    aval_final_desempate.update(nota_desempate: classificado)
                  end
                  Premio.where("inscricaos_competicao_id = #{aval_final_desempate.id} and posto like '%conjunto progênie de marcha%'").delete_all
                  qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: aval_final_desempate.inscricao.pelagem, marcha: aval_final_desempate.inscricao.marcha).count
                  if classificado == 1 && (!aval_final_desempate.observacao_final.present? || aval_final_desempate.observacao_final == 'asterisco')
                    @campeao = aval_final_desempate.id
                    Premio.create posto: 'campeão conjunto progênie de marcha', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id , inscricaos_competicao_id: aval_final_desempate.id, nome_animal: aval_final_desempate.inscricao.nome_animal, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 15 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 15 * 1, pontuacao: 15 * 1, animais_julgados: qtde_competidores 
                  elsif classificado == 2 && (!aval_final_desempate.observacao_final.present? || aval_final_desempate.observacao_final == 'asterisco')
                    Premio.create posto: 'reservado conjunto progênie de marcha', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id , inscricaos_competicao_id: aval_final_desempate.id, nome_animal: aval_final_desempate.inscricao.nome_animal, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 10 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 10 * 1, pontuacao: 10 * 1, animais_julgados: qtde_competidores
                  end
                end
                aval.each do |update_aval|
                  update_aval.update classificacao: classificado
                end
              end
              classificado += 1
            end
            
            notas  = CompeticaoAvalicao.where("inscricao_id = #{insc_catalogo.first.inscricao_id} and tempo_executado is null and criterios_competicao_id = #{criterio.id}").where.not(nota: 0, nota: nil)

            classe = DescriptiveStatistics::Stats.new(notas.map{|i| i&.classificacao || nil})
            @nota_final += classe&.mode || 0

            stats_observacao = DescriptiveStatistics::Stats.new(notas.map{|i| i&.ocorrencia || nil})
            observacao_final = stats_observacao.mode rescue nil

            stats_aprumo = DescriptiveStatistics::Stats.new(notas.map{|i| i&.aprumacao || false})
            if aprumo_final == false
              aprumo_final = stats_aprumo.mode rescue false
            end
            stats_melhor_cabeca = DescriptiveStatistics::Stats.new(notas.map{|i| i&.melhor_cabeca || false})
            if melhor_cabeca_final == false
              melhor_cabeca_final = stats_melhor_cabeca.mode rescue false
            end
          end
      end

    #Atribuir a classificação de cada animal no cluster de avaliação - Competição Normal
    elsif competicaos_evento_id.competicao.modalidade.nome != "Competição Acasalamento"

      #define os critérios da competição (morfologia, marcha ou prova funcional)
      criterios = CriteriosCompeticao.where(competicao_id: competicaos_evento_id.competicao_id)
      #define variaveis iniciais
      
        #define a Inscricao Competicao do Animal percorrido atual.
        #@inscrito_nota_final = InscricaosCompeticao.find_by(inscricao_id: insc_catalogo.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)

        criterios.each do |criterio|
          #Se o peso igual a zero, este critério será apenas informativo, como os da provas funcionais.
          if criterio.peso > 0
            new_imprimir_parcial_convencional(criterio)

          #SE FOR PROVA FUNCIONAL
          else
            new_imprimir_parcial_funcional(criterio, inscritos_catalogo, competicaos_evento_id)
          end
        end

        # if observacao_final&.present? && observacao_final != 'asterisco'
        #   @nota_final = 9999
        # end
        
      #   if @inscrito_nota_final.competicao.desempate_em == 'prova_funcional'
      #     if @tempo_final.present? || @tempo_final || 0 > 0
      #       @inscrito_nota_final.update(nota_final: @nota_final, nota_desempate: @tempo_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      #     else
      #       @inscrito_nota_final.update(nota_final: @nota_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      #     end
      #   else
      #     @inscrito_nota_final.update(nota_final: @nota_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      #   end
      # end
    end
  
    @comp_avaliacaos = CompeticaoAvalicao.where(catalogo_id: params[:catalogo]).where.not(nota: nil).order('competicao_juri_id')

    @campeoes_ca = InscricaosCompeticao.where(inscricao_id: @comp_avaliacaos.map{|z| z.inscricao_id}, competicaos_evento_id: competicaos_evento_id.id)
    @campeoes_marcha = @campeoes_ca.where('campeao_anterior_json @> ?', [{posto: 'campeão marcha categoria'}].to_json).or(@campeoes_ca.where('campeao_anterior_json @> ?', [{posto: 'reservado marcha categoria'}].to_json))
    @campeoes_morfologia = @campeoes_ca.where('campeao_anterior_json @> ?', [{posto: 'campeão morfologia categoria'}].to_json).or(@campeoes_ca.where('campeao_anterior_json @> ?', [{posto: 'reservado morfologia categoria'}].to_json))
    
    respond_to do |format|
        format.html do 
          render 'competicao_avalicaos/parcial_notas.pdf.erb', template: 'competicao_avalicaos/parcial_notas', layout: "layouts/catalogo"
        end
        format.json
        format.pdf do 
          render template: 'competicao_avalicaos/parcial_notas', pdf: 'parcial_notas', page_size: 'A3'
        end
      end
  end

  #Imprimir resultado Final onde deve desconsiderar os animais só marcha (Campeão da Raça)
  def imprimir_resultado
    competicaos_evento_id = CompeticaosEvento.find(params[:competicao_evento_id])
    inscritos_catalogo = Catalogo.where(id: params[:catalogo])

    #Acasalamento e Progênie
    if  competicaos_evento_id.competicao.modalidade.nome == "Competição Acasalamento" or competicaos_evento_id.competicao.modalidade.nome == "Competição Progênie"
      inscritos_catalogo = inscritos_catalogo.joins('INNER JOIN inscricaos on inscricaos.id = catalogos.inscricao_id').where.not('inscricaos.so_marcha = true')
      inscritos_catalogo.each do |insc_catalogo|
        @nota_final = 0
        melhor_cabeca_final = false
        observacao_final = nil
        aprumo_final = false

        @inscrito_nota_final = InscricaosCompeticao.find_by(inscricao_id: insc_catalogo.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)
        criterios = CriteriosCompeticao.where(competicao_id: competicaos_evento_id.competicao_id)
        @nota_final = 0

        criterios.each do |criterio|
            classificaos = CompeticaoAvalicao.joins('INNER JOIN catalogos on competicao_avalicaos.catalogo_id = catalogos.id').where(criterios_competicao_id: criterio.id, evento_id: $evento.id, catalogo_id: inscritos_catalogo.map{|p| p.id}).where.not(nota: 0).where.not(nota: nil).group('numero_colete_progenie')
            classificaos_sum = classificaos.sum('nota')
            classificaos_sum.merge!(classificaos.sum('nota_juri_desempate')) { |key, important, default| [important, default].flatten }
            classificaos_sum = classificaos_sum.sort_by{| k, v | v}
            classificado = 1

            #Faz a correção da Classificação do Animal removendo os só para Marcha. Regra de negócio da impressão Final.
            classificaos_sum.each do |colete_progenie,nota|
              inscricaos = Catalogo.where(id: params[:catalogo], numero_colete_progenie: colete_progenie)
              inscricaos.each do |inscricao|
                aval = CompeticaoAvalicao.where(inscricao_id: inscricao.inscricao_id, criterios_competicao_id: criterio.id)
                aval_final_desempate = InscricaosCompeticao.find_by(inscricao_id: inscricao.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)
                if criterio.criterios_avaliacao.nome == "Nota Morfologia" && @inscrito_nota_final.competicao.desempate_em == 'morfologia'
                  aval_final_desempate.update(nota_desempate: classificado)
                elsif criterio.criterios_avaliacao.nome == "Nota Marcha" && @inscrito_nota_final.competicao.desempate_em == 'marcha'
                  aval_final_desempate.update(nota_desempate: classificado)
                end
                aval.each do |update_aval|
                  if aval_final_desempate.observacao_final&.present?
                    if aval_final_desempate.observacao_final != "asterisco"
                      update_aval.update classificacao: 999
                      if classificado != 1
                        classificado -= 1
                      end
                      if criterio.criterios_avaliacao.nome == "Nota Morfologia" && @inscrito_nota_final.competicao.desempate_em == 'morfologia'
                        aval_final_desempate.update(nota_desempate: 999)
                      elsif criterio.criterios_avaliacao.nome == "Nota Marcha" && @inscrito_nota_final.competicao.desempate_em == 'marcha'
                        aval_final_desempate.update(nota_desempate: 999)
                      end
                    else
                      update_aval.update classificacao: classificado
                    end 
                  else
                    update_aval.update classificacao: classificado
                  end
                end
              end
              classificado += 1
            end
            
            notas  = CompeticaoAvalicao.where("inscricao_id = #{insc_catalogo.inscricao_id} and tempo_executado is null and criterios_competicao_id = #{criterio.id}").where.not(nota: 0, nota: nil)
            classe = DescriptiveStatistics::Stats.new(notas.map{|i| i&.classificacao || nil})
            @nota_final += classe&.mode || 0

            stats_observacao = DescriptiveStatistics::Stats.new(notas.map{|i| i&.ocorrencia || nil})
            observacao_final = stats_observacao.mode rescue nil

            stats_aprumo = DescriptiveStatistics::Stats.new(notas.map{|i| i&.aprumacao || false})
            if aprumo_final == false
              aprumo_final = stats_aprumo.mode rescue false
            end
            stats_melhor_cabeca = DescriptiveStatistics::Stats.new(notas.map{|i| i&.melhor_cabeca || false})
            if melhor_cabeca_final == false
              melhor_cabeca_final = stats_melhor_cabeca.mode rescue false
            end
            
        end

        if observacao_final&.present? && observacao_final != 'asterisco'
          @nota_final = 9999
        end

        if @inscrito_nota_final.competicao.desempate_em == 'prova_funcional'
          if @tempo_final.present? || @tempo_final || 0 > 0
            if @inscrito_nota_final.competicao.modalidade.nome == 'Competição Castrado de Sela'
              @inscrito_nota_final.update(nota_final: (@nota_final.to_f + @tempo_final.to_f), nota_desempate: @tempo_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
            else
              @inscrito_nota_final.update(nota_final: @nota_final,nota_desempate: @tempo_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
            end
          else
            @inscrito_nota_final.update(nota_final: @nota_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
          end
        else
            @inscrito_nota_final.update(nota_final: @nota_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
        end
      end

      @nota_morfologia = 0
      competidores = InscricaosCompeticao.where(competicaos_evento_id: inscritos_catalogo.map{|m| m.competicaos_evento_id})
      competidores = competidores.joins('LEFT JOIN inscricaos on inscricaos.id = inscricaos_competicaos.inscricao_id').where.not('inscricaos.so_marcha = true')
      competidores = competidores.where(inscricao_id: inscritos_catalogo.map{|m| m.inscricao_id}).order(:nota_final, :nota_desempate, :observacao_final)
      
      position = 1
      arrumar = false
      arrumado = false
      position_arrumar = 4
      position_true = 1
      
      if  competicaos_evento_id.competicao.modalidade.nome == "Competição Acasalamento"
        competidores.group_by{|c| c.grupo_progenie}.each do |progenie, competidores|
          
          competidores.each do |competidor|
            catalogo_comp = Catalogo.find_by(inscricao_id: competidor.inscricao_id)
            numero_colete = catalogo_comp.numero_colete
            Premio.where("inscricaos_competicao_id = #{competidor.id} and posto like '%acasalamento%'").delete_all
            qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: competidor.inscricao.pelagem, marcha: competidor.inscricao.marcha).count

            if competidor.observacao_final == 'asterisco' && (position == 1 || position == 2)
              position_true = position
              position = 3
              arrumar = true
            end
  
            if position == 3 && arrumado == true
              position = position_arrumar
              position_arrumar += 1
            end

            if position == 1 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
              @campeao = competidor.id
              competidor.update posto: 'campeão', campeao: @campeao
              Premio.create posto: 'campeão acasalamento', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, nome_animal: competidor.inscricao.nome_animal, nome_animal: competidor.inscricao.nome_animal, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 7.5 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 7.5 * 1, pontuacao: 7.5 * 1, animais_julgados: qtde_competidores
            elsif position == 2 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
              competidor.update posto: 'reservado', campeao: @campeao
              Premio.create posto: 'reservado acasalamento', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , nome_animal: competidor.inscricao.nome_animal,  inscricao_campeao_id: @campeao , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 5 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 5 * 1, pontuacao: 5 * 1, animais_julgados: qtde_competidores
            else
              competidor.update posto: '', campeao: ''
            end
          end
          if arrumar == true
            position = position_true
            arrumado = true
            arrumar = false
          else
            position += 1
          end
        end
      end

      if  competicaos_evento_id.competicao.modalidade.nome == "Competição Progênie"
        competidores.group_by{|c| c.grupo_progenie}.each do |progenie, competidores|
          competidores.each do |competidor|
            catalogo_comp = Catalogo.find_by(inscricao_id: competidor.inscricao_id)
            numero_colete = catalogo_comp.numero_colete
            Premio.where("inscricaos_competicao_id = #{competidor.id} and posto like '%conjunto de progênie%'").delete_all
            qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: competidor.inscricao.pelagem, marcha: competidor.inscricao.marcha).count


            if competidor.observacao_final == 'asterisco' && (position == 1 || position == 2)
              position_true = position
              position = 3
              arrumar = true
            end
  
            if position == 3 && arrumado == true
              position = position_arrumar
              position_arrumar += 1
            end

            if position == 1 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
              @campeao = competidor.id
              competidor.update posto: 'campeão', campeao: @campeao
              Premio.create posto: 'campeão conjunto de progênie', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 10 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 10 * 1, pontuacao: 10 * 1, animais_julgados: qtde_competidores
            
            elsif position == 2 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
              competidor.update posto: 'reservado', campeao: @campeao
              Premio.create posto: 'reservado conjunto de progênie', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 7 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 7 * 1, pontuacao: 7 * 1, animais_julgados: qtde_competidores
            else
              competidor.update posto: '', campeao: ''
            end
          end
          if arrumar == true
            position = position_true
            arrumado = true
            arrumar = false
          else
            position += 1
          end
        end
      end
    
    #Convêncionais
    else
      new_imprimir_final_convencional(inscritos_catalogo, competicaos_evento_id)
    end
  
    #@catalogo = Catalogo.where(id: params[:catalogo])
    @comp_avaliacaos = CompeticaoAvalicao.where(catalogo_id: params[:catalogo]).where.not(nota: nil).order('competicao_juri_id')
    @insc_avalicao = InscricaosCompeticao.where(inscricao_id: @comp_avaliacaos.map{|i| i.inscricao_id})
    @insc_avalicao = @insc_avalicao.where(competicaos_evento_id: @comp_avaliacaos.map{|i| i.competicao_juri.competicaos_evento_id})
    respond_to do |format|
        format.html do 
          render 'competicao_avalicaos/imprimir_resultado.pdf.erb', template: 'competicao_avalicaos/imprimir_resultado', layout: "layouts/catalogo"
        end
        format.json
        format.pdf do 
          render template: 'competicao_avalicaos/imprimir_resultado', pdf: 'imprimir_resultado', page_size: 'A3'
        end
      end
  end

  # POST /competicao_avalicaos
  # POST /competicao_avalicaos.json
  def create
  end

  # PATCH/PUT /competicao_avalicaos/1
  # PATCH/PUT /competicao_avalicaos/1.json
  def update
    render json: {success: true, item_id: params[:key_id]}
    # return true, "Nota Atualizada com sucesso"
  end
  
  def set_nota_progenie
    
    ocorrencia = params.require(:competicao_avalicao).permit(:ocorrencia).dig(:ocorrencia)
    competicaos_evento_id = CompeticaosEvento.where("evento_id = #{$evento.id} and competicao_id = #{params[:competicao_avalicao][:competicao_id]}").first
    competicao_juri = CompeticaoJuri.find(params.dig(:competicao_avalicao, :competicao_juri_id))
    catalogo_animal = Catalogo.find_by(inscricao_id: params[:competicao_avalicao][:inscricao_id], competicaos_evento_id: competicaos_evento_id.id)
    catalogo = Catalogo.where(competicaos_evento_id: competicaos_evento_id.id, numero_colete_progenie:catalogo_animal.numero_colete_progenie)
    inscricaos = Inscricao.where(id: catalogo.map{|c| c.inscricao_id})
    melhor_cabeca_final = false
    observacao_final = nil
    aprumo_final = false
    
    criterio_funcional_tempo, cas = 0, []
    
    inscricaos.each do |inscricao_master|
      CompeticaoAvalicao.where(competicao_juri_id: competicao_juri.id, inscricao_id: inscricao_master.id).delete_all rescue nil
        params[:nota].each do |p|
          criterio_competicao = CriteriosCompeticao.find_by(criterios_avaliacao_id: p.first, competicao_id: params[:competicao_avalicao][:competicao_id])
      
          if criterio_competicao.present?
            if criterio_competicao.criterios_avaliacao.cluster_criterios_avaliacao.funcional
              criterio_funcional_tempo += p.last.to_i * 5
            end
            nota_juri = p.last
            if competicao_juri&.juri_desempate?
              nota_desempate = p.last.to_f
            else
              nota_desempate = 99
            end
            
            ca = CompeticaoAvalicao.create(
              melhor_cabeca:           params.require(:competicao_avalicao).dig(:melhor_cabeca),
              aprumacao:               params.require(:competicao_avalicao).dig(:aprumacao),
              ocorrencia:              ocorrencia,
              competicao_juri_id:      params.dig(:competicao_avalicao, :competicao_juri_id),
              inscricao_id:            inscricao_master.id,
              criterios_competicao_id: criterio_competicao&.id,
              nota:                    nota_juri,
              catalogo_id:             params.dig(:competicao_avalicao, :catalogo_id),
              evento_id:               $evento.id,
              nota_juri_desempate:     nota_desempate
              #nome_juri_desempate:     params.dig(:juri_desempate_id)
            )
            end
        end

      tempo_executado = 0
      if criterio_funcional_tempo > 0
        _tempo_executado = params.dig(:competicao_avalicao, :tempo_executado).split(":").map(&:to_i)
        tempo_executado = (_tempo_executado.first * 60) + _tempo_executado.last
        inscricao_master.competicao_avaliacaos.update_all(tempo_executado: tempo_executado, tempo_final: tempo_executado + criterio_funcional_tempo)
      end

      catalogo = Catalogo.find_by(inscricao_id: inscricao_master.id, competicaos_evento_id: competicaos_evento_id.id)
      @inscritos_catalogo = Catalogo.where(competicaos_evento_id: competicaos_evento_id.id, catalogo_nome_id: catalogo.catalogo_nome_id)
    end
  end

  # POST /competicao_avalicaos/set_juri_desempate
  def set_juri_desempate
    prm = params.permit(juri_desempate: {}).dig(:juri_desempate).reject{ |k,v| v.blank?}
    CompeticaoJuri.update_all(juri_desempate: false)
    prm.each do |cluster_criterios_avaliacao_id, competicao_juri_id|
      #Atualizar todos os juris como false
      # Setar o juri em específico como o de desempate
      CompeticaoJuri.find(competicao_juri_id).update(juri_desempate: true)
    end

    render json: {success: true}
  end

  def set_notas
    GC.start
    ocorrencia = params.dig(:competicao_avalicao, :ocorrencia)
    competicaos_evento = CompeticaosEvento.find_by(evento_id: $evento.id, competicao_id: params[:competicao_avalicao][:competicao_id])
    competicao_juri = CompeticaoJuri.find(params.dig(:competicao_avalicao, :competicao_juri_id))
    
    if false
      competicao_juris = CompeticaoJuri.where(competicaos_evento_id: competicaos_evento.id)
      competicao_juris.update_all juri_desempate: false
      competicao_juri.update(juri_desempate: true)
    end
    
    if  competicaos_evento.competicao.modalidade.nome == "Competição Acasalamento" or competicaos_evento.competicao.modalidade.nome == "Competição Progênie"
      set_nota_progenie()
    else
      
      melhor_cabeca_final = false
      observacao_final = nil
      aprumo_final = false

      inscricao = Inscricao.find(params.dig(:competicao_avalicao, :inscricao_id))
      criterio_funcional_tempo, cas = 0, []

      params[:nota]&.each do |p|

        criterio_competicao = CriteriosCompeticao.find_by(criterios_avaliacao_id: p.first, competicao_id: params[:competicao_avalicao][:competicao_id])
        if criterio_competicao.present?
          if p.last.present?
            CompeticaoAvalicao.where(criterios_competicao_id: criterio_competicao&.id, competicao_juri_id: competicao_juri.id, inscricao_id: params.dig(:competicao_avalicao, :inscricao_id)).delete_all rescue nil
          end

          if criterio_competicao.criterios_avaliacao.cluster_criterios_avaliacao.funcional
            criterio_funcional_tempo += p.last.to_i * 5
          end
          
          nota_juri = p.last
          if competicao_juri&.juri_desempate
            nota_desempate = p.last.to_f
          else
            nota_desempate = 99
          end

          # if(ocorrencia == "desclassificado")
          #   CompeticaoAvalicao.where(inscricao_id: params.dig(:competicao_avalicao, :inscricao_id), catalogo_id: params.dig(:competicao_avalicao, :catalogo_id), evento_id: $evento.id).update(nota: 99)
          # end

          ca = CompeticaoAvalicao.new(
            melhor_cabeca:           params.require(:competicao_avalicao).dig(:melhor_cabeca),
            aprumacao:               params.require(:competicao_avalicao).dig(:aprumacao),
            ocorrencia:              ocorrencia,
            competicao_juri_id:      params.dig(:competicao_avalicao, :competicao_juri_id),
            inscricao_id:            params.dig(:competicao_avalicao, :inscricao_id),
            criterios_competicao_id: criterio_competicao&.id,
            nota:                    nota_juri,
            catalogo_id:             params.dig(:competicao_avalicao, :catalogo_id),
            evento_id:               $evento.id,
            nota_juri_desempate:     nota_desempate
          )
          ca.save!

          # competicao_juri.update juri_desempate: params.dig(:competicao_juris, :juri_desempate)
        end
      end
      tempo_executado = 0
      if criterio_funcional_tempo > 0
        _tempo_executado = params.dig(:competicao_avalicao, :tempo_executado).split(":").map(&:to_f)
        tempo_executado = (_tempo_executado.first * 60) + _tempo_executado.last
        inscricao.competicao_avaliacaos.update_all(tempo_executado: tempo_executado, tempo_final: tempo_executado + criterio_funcional_tempo)
      end

      # render json: {message: "adsasdasdasd"}
    end
  end

  # DELETE /competicao_avalicaos/1
  # DELETE /competicao_avalicaos/1.json
  def destroy
    @competicao_avalicao.destroy
    render json: { ok: true }
  end

  def new_imprimir_parcial_convencional(criterio)

        competicaos_evento_id = CompeticaosEvento.find(params[:competicao_evento_id])
        inscritos_catalogo = Catalogo.where(id: params[:catalogo])
        criterios = CriteriosCompeticao.where(competicao_id: competicaos_evento_id.competicao_id)
        @nota_final = 0
        melhor_cabeca_final = false
        observacao_final = nil
        aprumo_final = false
        classificado = 1
        arrumar = false
        arrumado = false
        classificado_arrumar = 4

        classificaos = CompeticaoAvalicao.where(criterios_competicao_id: criterio.id, evento_id: $evento.id, catalogo_id: inscritos_catalogo.map{|p| p.id}).where.not(nota: 0).where.not(nota: nil).group('inscricao_id')
        classificaos_sum = classificaos.sum('nota')           
        classificaos_sum.merge!(classificaos.sum('nota_juri_desempate')) { |key, important, default| [important, default].flatten }
        classificaos_sum = classificaos_sum.sort_by{| k, v | v}
        classificado = 1
        
        classificaos_sum.each do |inscricao,nota|  
          notas  = CompeticaoAvalicao.where("inscricao_id = #{inscricao} and tempo_executado is null and criterios_competicao_id = #{criterio.id}").where.not(nota: 0, nota: nil)
          classe = DescriptiveStatistics::Stats.new(notas.map{|i| i&.classificacao || nil})
          @nota_final += classe&.mode || 0       

          observa = CompeticaoAvalicao.where("inscricao_id = #{inscricao} and tempo_executado is null and criterios_competicao_id = #{criterio.id}").where.not(nota: 0, nota: nil)
          obs_criterio = DescriptiveStatistics::Stats.new(observa.map{|i| i&.ocorrencia || nil}).mode

          
          if obs_criterio == 'asterisco' && (classificado == 1 || classificado == 2)
            classificado_true = classificado
            classificado = 3
            arrumar = true
          end
        
          if classificado == 3 && arrumado == true
            classificado = classificado_arrumar
            classificado_arrumar += 1
          end
          
          aval = CompeticaoAvalicao.where(inscricao_id: inscricao, criterios_competicao_id: criterio.id)
          aval_final_desempate = InscricaosCompeticao.find_by(inscricao_id: inscricao, competicaos_evento_id: competicaos_evento_id.id)
          if criterio.criterios_avaliacao.nome == "Nota Morfologia" && competicaos_evento_id.competicao.desempate_em == 'morfologia'
            aval_final_desempate.update(nota_desempate: classificado)
          elsif criterio.criterios_avaliacao.nome == "Nota Marcha" && competicaos_evento_id.competicao.desempate_em == 'marcha'
            aval_final_desempate.update(nota_desempate: classificado)
          end

          #Adiciona os premiados de Marcha na tabela de premios
          if criterio.criterios_avaliacao.nome == "Nota Marcha"
            if competicaos_evento_id.competicao.modalidade.nome == "Grande Competição"
              
              #EM VALIDAÇÃO....
              aval_final_desempate = InscricaosCompeticao.where(inscricao_id: inscricao, competicaos_evento_id: competicaos_evento_id.id)
              aval_final_desempate = aval_final_desempate.where('campeao_anterior_json @> ?', [{posto: 'campeão marcha categoria'}].to_json).or(aval_final_desempate.where('campeao_anterior_json @> ?', [{posto: 'reservado marcha categoria'}].to_json)).first                      
              if aval_final_desempate.present?
                if aval_final_desempate.inscricao.faixa_etaria >= 36
                  pontos_campeao = 40
                  pontos_reservado = 30
                else
                  pontos_campeao = 30
                  pontos_reservado = 20
                end
                Premio.where("inscricaos_competicao_id = #{aval_final_desempate.id} and posto like '%grande marchador%'").delete_all
                qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: aval_final_desempate.inscricao.pelagem, marcha: aval_final_desempate.inscricao.marcha).count
                if classificado == 1 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  @campeao = aval_final_desempate.id
                  Premio.create posto: 'campeão grande marchador', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: pontos_campeao * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: pontos_campeao * 1, pontuacao: pontos_campeao * 1, animais_julgados: qtde_competidores 
                elsif classificado == 2 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  Premio.create posto: 'reservado grande marchador', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: pontos_reservado * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: pontos_reservado * 1, pontuacao: pontos_reservado * 1, animais_julgados: qtde_competidores
                end
              end

            elsif competicaos_evento_id.competicao.modalidade.nome == "Amador"
              
            elsif competicaos_evento_id.competicao.modalidade.nome == "Competição Criadores"

            elsif competicaos_evento_id.competicao.modalidade.nome == "Melhor Cabeça"

            elsif competicaos_evento_id.competicao.modalidade.nome == "Melhor Aprumo"

            else
              Premio.where("inscricaos_competicao_id = #{aval_final_desempate.id} and posto like '%marcha categoria%'").delete_all
              qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: aval_final_desempate.inscricao.pelagem, marcha: aval_final_desempate.inscricao.marcha).count
              
              if aval_final_desempate.inscricao.faixa_etaria < 36
                pontos_campeao = 12
                pontos_reservado = 6
                if classificado == 1 && (!obs_criterio.present? || obs_criterio == 'asterisco' )
                  @campeao = aval_final_desempate.id
                  Premio.create posto: 'campeão marcha categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id , nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: pontos_campeao * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: pontos_campeao * 1, pontuacao: pontos_campeao * 1, animais_julgados: qtde_competidores 
                elsif classificado == 2 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  Premio.create posto: 'reservado marcha categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id , nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: pontos_reservado * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: pontos_reservado * 1, pontuacao: pontos_reservado * 1, animais_julgados: qtde_competidores
                end
              else
                pontos_campeao = 20
                pontos_reservado = 10 

                if classificado == 1 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  @campeao = aval_final_desempate.id
                  Premio.create posto: 'campeão marcha categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: pontos_campeao * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: pontos_campeao * 1, pontuacao: pontos_campeao * 1, animais_julgados: qtde_competidores 
                elsif classificado == 2 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  Premio.create posto: 'reservado marcha categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: pontos_reservado * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: pontos_reservado * 1, pontuacao: pontos_reservado * 1, animais_julgados: qtde_competidores
                elsif classificado == 3 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  Premio.create posto: '1 Premio marcha categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 5 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 5 * 1, pontuacao: 5 * 1, animais_julgados: qtde_competidores
                elsif classificado == 4 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  Premio.create posto: '2 Premio marcha categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 4 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 4 * 1, pontuacao: 4 * 1, animais_julgados: qtde_competidores
                elsif classificado == 5 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  Premio.create posto: '3 Premio marcha categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 3 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 3 * 1, pontuacao: 3 * 1, animais_julgados: qtde_competidores
                elsif classificado == 6 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  Premio.create posto: '4 Premio marcha categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 2 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 2 * 1, pontuacao: 2 * 1, animais_julgados: qtde_competidores
                elsif classificado == 7 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  Premio.create posto: '5 Premio marcha categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 1 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 1 * 1, pontuacao: 1 * 1, animais_julgados: qtde_competidores
                end
              end
            end
          end

          #Adiciona os premiados de Morfologia na tabela de premios
          if criterio.criterios_avaliacao.nome == "Nota Morfologia"
            if competicaos_evento_id.competicao.modalidade.nome == "Grande Competição"

              #EM VALIDAÇÃO....
              aval_final_desempate = InscricaosCompeticao.where(inscricao_id: inscricao, competicaos_evento_id: competicaos_evento_id.id)
              aval_final_desempate = aval_final_desempate.where('campeao_anterior_json @> ?', [{posto: 'campeão morfologia categoria'}].to_json).or(aval_final_desempate.where('campeao_anterior_json @> ?', [{posto: 'reservado morfologia categoria'}].to_json)).first

              if aval_final_desempate.present?
                Premio.where("inscricaos_competicao_id = #{aval_final_desempate.id} and posto like '%grande morfologia%'").delete_all
                qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: aval_final_desempate.inscricao.pelagem, marcha: aval_final_desempate.inscricao.marcha).count
                if classificado == 1 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  @campeao = aval_final_desempate.id
                  Premio.create posto: 'campeão grande morfologia', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 30 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 30 * 1, pontuacao: 30 * 1, animais_julgados: qtde_competidores 
                elsif classificado == 2 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                  Premio.create posto: 'reservado grande morfologia', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 20 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 20 * 1, pontuacao: 20 * 1, animais_julgados: qtde_competidores
                end
              end
            elsif competicaos_evento_id.competicao.modalidade.nome == "Amador"
              
            elsif competicaos_evento_id.competicao.modalidade.nome == "Competição Criadores"

            elsif competicaos_evento_id.competicao.modalidade.nome == "Melhor Cabeça"

            elsif competicaos_evento_id.competicao.modalidade.nome == "Melhor Aprumo"

            else

              Premio.where("inscricaos_competicao_id = #{aval_final_desempate.id} and posto like '%morfologia categoria%'").delete_all
              qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: aval_final_desempate.inscricao.pelagem, marcha: aval_final_desempate.inscricao.marcha).count
              if classificado == 1 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                @campeao = aval_final_desempate.id
                Premio.create posto: 'campeão morfologia categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 12 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 12 * 1, pontuacao: 12 * 1, animais_julgados: qtde_competidores 
              elsif classificado == 2 && (!obs_criterio.present? || obs_criterio == 'asterisco')
                Premio.create posto: 'reservado morfologia categoria', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 6 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 6 * 1, pontuacao: 6 * 1, animais_julgados: qtde_competidores 
              end
            end
          end

          ##### FAZER O REGISTRO DO ANIMAL
        if !observacao_final.present?
          stats_observacao = DescriptiveStatistics::Stats.new(notas.map{|i| i&.ocorrencia || nil})
          observacao_final = stats_observacao.mode rescue nil
        elsif observacao_final == "asterisco"
          stats_observacao_2 = DescriptiveStatistics::Stats.new(notas.map{|i| i&.ocorrencia || nil})
          if stats_observacao_2.present?
            observacao_final = stats_observacao_2.mode rescue nil
          end
        end

        stats_aprumo = DescriptiveStatistics::Stats.new(notas.map{|i| i&.aprumacao || false})
        if aprumo_final == false
          aprumo_final = stats_aprumo.mode rescue false
        end
        stats_melhor_cabeca = DescriptiveStatistics::Stats.new(notas.map{|i| i&.melhor_cabeca || false})
        if melhor_cabeca_final == false
          melhor_cabeca_final = stats_melhor_cabeca.mode rescue false
        end


        aval.each do |update_aval|
          update_aval.update classificacao: classificado
        end

        if arrumar == true
          classificado = classificado_true
          arrumado = true
          arrumar = false
        else
          classificado += 1
        end
      end
  end

  def new_imprimir_parcial_funcional(criterio, inscritos_catalogo, competicaos_evento_id)
    @nota_final = 0
    melhor_cabeca_final = false
    observacao_final = nil
    aprumo_final = false
    
    classificaos = CompeticaoAvalicao.where(criterios_competicao_id: criterio.id, evento_id: $evento.id, catalogo_id: inscritos_catalogo.map{|p| p.id}).where.not(nota: nil).group('inscricao_id')
    classificaos_sum = classificaos.sum('tempo_final')
    classificaos_sum = classificaos_sum.sort_by{| k, v | v rescue 0}
    classificado = 1
    classificaos_sum.each do |inscricao,nota|
      aval = CompeticaoAvalicao.where(inscricao_id: inscricao, criterios_competicao_id: criterio.id)
      aval_final_desempate = InscricaosCompeticao.find_by(inscricao_id: inscricao, competicaos_evento_id: competicaos_evento_id.id)

      if competicaos_evento_id.competicao.modalidade.nome == "Grande Competição"
        if competicaos_evento_id.competicao.nome == "Prova Esportiva"
          Premio.where("inscricaos_competicao_id = #{aval_final_desempate.id} and posto like '%Campeão Prova Esportiva%'").delete_all
          qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: aval_final_desempate.inscricao.pelagem, marcha: aval_final_desempate.inscricao.marcha).count
          if classificado == 1 && (!obs_criterio.present? || obs_criterio == 'asterisco')
            @campeao = aval_final_desempate.id
            Premio.create posto: 'Campeão Prova Esportiva', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 20 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 20 * 1, pontuacao: 20 * 1, animais_julgados: qtde_competidores 
          elsif classificado == 2 && (!obs_criterio.present? || obs_criterio == 'asterisco')
            Premio.create posto: 'reservado Campeão Prova Esportiva', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 10 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 10 * 1, pontuacao: 10 * 1, animais_julgados: qtde_competidores 
          end
        else
          Premio.where("inscricaos_competicao_id = #{aval_final_desempate.id} and posto like '%campeão campolina em ação%'").delete_all
          qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: aval_final_desempate.inscricao.pelagem, marcha: aval_final_desempate.inscricao.marcha).count
          if classificado == 1 && (!obs_criterio.present? || obs_criterio == 'asterisco')
            @campeao = aval_final_desempate.id
            Premio.create posto: 'grande campeão campolina em ação', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id , nome_animal: aval_final_desempate.inscricao.nome_animal,inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 30 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 30 * 1, pontuacao: 30 * 1, animais_julgados: qtde_competidores 
          elsif classificado == 2 && (!obs_criterio.present? || obs_criterio == 'asterisco')
            Premio.create posto: 'reservado grande campeão campolina em ação', numero_colete: aval.first.catalogo.numero_colete , nome_catalogo: aval.first.catalogo.nome_catalogo , inscricao_id: aval_final_desempate.inscricao_id ,nome_animal: aval_final_desempate.inscricao.nome_animal, inscricaos_competicao_id: aval_final_desempate.id, competicaos_evento_id: aval_final_desempate.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: aval_final_desempate.inscricao.expositor.nome, pontuacao_expositor: 20 * 1 , criador: aval_final_desempate.inscricao.criador.nome, pontuacao_criador: 20 * 1, pontuacao: 20 * 1, animais_julgados: qtde_competidores 
          end
        end
      elsif competicaos_evento_id.competicao.modalidade.nome == "Amador"
          
      elsif competicaos_evento_id.competicao.modalidade.nome == "Competição Criadores"

      elsif competicaos_evento_id.competicao.modalidade.nome == "Melhor Cabeça"

      elsif competicaos_evento_id.competicao.modalidade.nome == "Melhor Aprumo"
      
      else

      end

      aval.each do |update_aval|
        if update_aval.inscricao_id == inscricao
          @tempo_final = classificado
        end
        update_aval.update classificacao: classificado
      end
      classificado += 1
    end
  end

  def new_imprimir_final_convencional(inscritos_catalogo, competicaos_evento_id)
    inscritos_catalogo = inscritos_catalogo.joins('INNER JOIN inscricaos on inscricaos.id = catalogos.inscricao_id').where.not('inscricaos.so_marcha = true')
    criterios = CriteriosCompeticao.where(competicao_id: competicaos_evento_id.competicao_id)

    inscritos_catalogo.each do |insc_catalogo|
      @nota_final = 0
      melhor_cabeca_final = false
      observacao_final = nil
      aprumo_final = false
      passar_1x = false
      classificado = 1
      arrumar = false
      arrumado = false
      classificado_arrumar = 4

      @inscrito_nota_final = InscricaosCompeticao.find_by(inscricao_id: insc_catalogo.inscricao_id, competicaos_evento_id: competicaos_evento_id.id)

      criterios.each do |criterio|

        if criterio.peso > 0
          classificaos = CompeticaoAvalicao.where(criterios_competicao_id: criterio.id, evento_id: $evento.id, catalogo_id: inscritos_catalogo.map{|p| p.id}).where.not(nota: 0).where.not(nota: nil).group('inscricao_id')
          classificaos_sum = classificaos.sum('nota')

          # if criterio.criterios_avaliacao.nome == "Nota Marcha"
          #   classificaos_sum.merge!(classificaos.maximum('nota')) { |key, important, default| [important, default].flatten }
          #   classificaos_sum.merge!(classificaos.minimum('nota')) { |key, important, default| [important, default].flatten }
          #   classificaos_sum = classificaos_sum.map{|k,e| [k, e.each_cons(3).map{|pair| pair[0] - pair[1] - pair[2]}]}.to_h
          # end

          classificaos_sum.merge!(classificaos.sum('nota_juri_desempate')) { |key, important, default| [important, default].flatten }
          classificaos_sum = classificaos_sum.sort_by{| k, v | v}
          classificado = 1
          notas  = CompeticaoAvalicao.where("inscricao_id = #{insc_catalogo.inscricao_id} and tempo_executado is null and criterios_competicao_id = #{criterio.id}").where.not(nota: 0, nota: nil)
          classe = DescriptiveStatistics::Stats.new(notas.map{|i| i&.classificacao || nil})

            if passar_1x == false
              classificaos_sum.each do |inscricao,nota|

                #@nota_final += classe&.mode || 0       

                observa = CompeticaoAvalicao.where("inscricao_id = #{inscricao} and tempo_executado is null and criterios_competicao_id = #{criterio.id}").where.not(nota: 0, nota: nil)
                obs_criterio = DescriptiveStatistics::Stats.new(observa.map{|i| i&.ocorrencia || nil}).mode

                
                if obs_criterio == 'asterisco' && (classificado == 1 || classificado == 2)
                  classificado_true = classificado
                  classificado = 3
                  arrumar = true
                end
              
                if classificado == 3 && arrumado == true
                  classificado = classificado_arrumar
                  classificado_arrumar += 1
                end

                aval = CompeticaoAvalicao.where(inscricao_id: inscricao, criterios_competicao_id: criterio.id)
                aval_final_desempate = InscricaosCompeticao.find_by(inscricao_id: inscricao, competicaos_evento_id: competicaos_evento_id.id)
                if criterio.criterios_avaliacao.nome == "Nota Morfologia" && @inscrito_nota_final.competicao.desempate_em == 'morfologia'
                  aval_final_desempate.update(nota_desempate: classificado)
                elsif criterio.criterios_avaliacao.nome == "Nota Marcha" && @inscrito_nota_final.competicao.desempate_em == 'marcha'
                  aval_final_desempate.update(nota_desempate: classificado)
                end

                if inscricao == insc_catalogo.inscricao_id
                  @nota_final += classificado || 0
                end

                if obs_criterio&.present?
                  if obs_criterio != "asterisco"
                    aval.update classificacao: 999
                    classificado -= 1
                    if criterio.criterios_avaliacao.nome == "Nota Morfologia" && @inscrito_nota_final.competicao.desempate_em == 'morfologia'
                      aval_final_desempate.update(nota_desempate: 999)
                    elsif criterio.criterios_avaliacao.nome == "Nota Marcha" && @inscrito_nota_final.competicao.desempate_em == 'marcha'
                      aval_final_desempate.update(nota_desempate: 999)
                    end
                  else
                    aval.update classificacao: classificado
                  end 
                else
                  aval.update classificacao: classificado
                end
                  
                if arrumar == true
                  classificado = classificado_true
                  arrumado = true
                  arrumar = false
                else
                  classificado += 1
                end
              end
            end

            stats_aprumo = DescriptiveStatistics::Stats.new(notas.map{|i| i&.aprumacao || false})
            if aprumo_final == false
              aprumo_final = stats_aprumo.mode rescue false
            end
            stats_melhor_cabeca = DescriptiveStatistics::Stats.new(notas.map{|i| i&.melhor_cabeca || false})
            if melhor_cabeca_final == false
              melhor_cabeca_final = stats_melhor_cabeca.mode rescue false
            end

            stats_observacao = DescriptiveStatistics::Stats.new(notas.map{|i| i&.ocorrencia || nil})
            observacao_final = stats_observacao.mode rescue nil
            
        #Prova Funcional
        else
          classificaos = CompeticaoAvalicao.where(criterios_competicao_id: criterio.id, evento_id: $evento.id, catalogo_id: inscritos_catalogo.map{|p| p.id}).where.not(nota: nil).group('inscricao_id')
          classificaos_sum = classificaos.sum('tempo_final')
          classificaos_sum = classificaos_sum.sort_by{| k, v | v rescue 0}
          classificado = 1

          classificaos_sum.each do |inscricao,nota|
            aval = CompeticaoAvalicao.where(inscricao_id: inscricao, criterios_competicao_id: criterio.id)
            aval.each do |update_aval|
              if update_aval.inscricao_id == @inscrito_nota_final.inscricao_id
                @tempo_final = classificado
              end
              update_aval.update classificacao: classificado
            end
            classificado += 1
          end

        end
      end

      passar_1x = true
      if observacao_final&.present? && observacao_final != 'asterisco'
        @nota_final = 9999
      end
      notas_ = CompeticaoAvalicao.where("inscricao_id = #{insc_catalogo.inscricao_id} and tempo_executado is null").where.not(nota: 0, nota: nil)

      if !observacao_final.present? && notas_&.count < 3 && notas_.map{|m| m.ocorrencia}&.include?("asterisco")
        observacao_final = "asterisco"
      end 

      if @inscrito_nota_final.competicao.desempate_em == 'prova_funcional'
        if @tempo_final.present? || @tempo_final || 0 > 0
          if @inscrito_nota_final.competicao.modalidade.nome == 'Competição Castrado de Sela'
            @inscrito_nota_final.update(nota_final: (@nota_final.to_f + @tempo_final.to_f), nota_desempate: @tempo_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
          else
            @inscrito_nota_final.update(nota_final: @nota_final,nota_desempate: @tempo_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
          end
        else
          @inscrito_nota_final.update(nota_final: @nota_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
        end
      else
          @inscrito_nota_final.update(nota_final: @nota_final, nota_final_melhor_cabeca: melhor_cabeca_final, nota_final_melhor_aprumo: aprumo_final, observacao_final: observacao_final)
      end
    end

    @nota_morfologia = 0
    
    competidores = InscricaosCompeticao.where(competicaos_evento_id: inscritos_catalogo.map{|m| m.competicaos_evento_id})
    competidores = competidores.joins('LEFT JOIN inscricaos on inscricaos.id = inscricaos_competicaos.inscricao_id').where.not('inscricaos.so_marcha = true')
    competidores = competidores.where(inscricao_id: inscritos_catalogo.map{|m| m.inscricao_id}).order(:nota_final, :nota_desempate, :observacao_final)

    position = 1
    arrumar = false
    arrumado = false
    position_arrumar = 4

    if  competicaos_evento_id.competicao.modalidade.nome == "Competição Castrado de Sela"
      competidores.each do |competidor|
        catalogo_comp = Catalogo.find_by(inscricao_id: competidor.inscricao_id)
        numero_colete = catalogo_comp.numero_colete
        Premio.where("inscricaos_competicao_id = #{competidor.id} and posto like '%convencional%'").delete_all

        if competidor.observacao_final == 'asterisco' && (position == 1 || position == 2)
          position_true = position
          position = 3
          arrumar = true
        end

        if position == 3 && arrumado == true
          position = position_arrumar
          position_arrumar += 1
        end
        
        qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: competidor.inscricao.pelagem, marcha: competidor.inscricao.marcha).count

        if position == 1 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          @campeao = competidor.id
          competidor.update posto: 'campeão', campeao: @campeao
          Premio.create posto: 'campeão convencional', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 10 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 10 * 1, pontuacao: 10 * 1, animais_julgados: qtde_competidores
        elsif position == 2 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: 'reservado', campeao: @campeao
          Premio.create posto: 'reservado convencional', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id ,nome_animal: competidor.inscricao.nome_animal,  inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 8 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 8 * 1, pontuacao: 8 * 1, animais_julgados: qtde_competidores
        elsif position == 3 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco') && arrumado != true
          competidor.update posto: '1 Premio', campeao: ''
          Premio.create posto: '1 Premio convencional', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id ,nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 5 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 5 * 1, pontuacao: 5 * 1, animais_julgados: qtde_competidores
        elsif position == 4 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: '2 Premio', campeao: ''
          Premio.create posto: '2 Premio convencional', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 4 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 4 * 1, pontuacao: 4 * 1, animais_julgados: qtde_competidores
        elsif position == 5 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: '3 Premio', campeao: ''
          Premio.create posto: '3 Premio convencional', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 3 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 3 * 1, pontuacao: 3 * 1, animais_julgados: qtde_competidores
        elsif position == 6 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: '4 Premio', campeao: ''
          Premio.create posto: '4 Premio convencional', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 2 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 2 * 1, pontuacao: 2 * 1, animais_julgados: qtde_competidores
        elsif position == 7  && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: '5 Premio', campeao: ''
          Premio.create posto: '5 Premio convencional', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 1 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 1 * 1, pontuacao: 1 * 1, animais_julgados: qtde_competidores
        else
          competidor.update posto: '', campeao: ''
        end

        if arrumar == true
          position = position_true
          arrumado = true
          arrumar = false
        else
          position += 1
        end

      end

    elsif competicaos_evento_id.competicao.modalidade.nome == "Melhor Cabeça"
      competidores.each do |competidor|
        if competidor.inscricao.faixa_etaria >= 36
          qtde_competidores = Inscricao.where('faixa_etaria >= 36').where(evento_id: $evento.id).count
        else
          qtde_competidores = Inscricao.where('faixa_etaria < 36').where(evento_id: $evento.id).count
        end
        catalogo_comp = Catalogo.find_by(inscricao_id: competidor.inscricao_id)
        numero_colete = catalogo_comp.numero_colete
        Premio.where("inscricaos_competicao_id = #{competidor.id} and nome_catalogo like '%Cabeça%'").delete_all
        if position == 1 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          @campeao = competidor.id
          competidor.update posto: 'campeão cabeça', campeao: @campeao
          Premio.create posto: 'campeão melhor cabeça', numero_colete: numero_colete , nome_catalogo: 'Melhor Cabeça' , inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, nome_animal: competidor.inscricao.nome_animal, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 10 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 10 * 1, pontuacao: 10 * 1, animais_julgados: qtde_competidores
        elsif position == 2 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: 'reservado cabeça', campeao: @campeao
          Premio.create posto: 'reservado melhor cabeça', numero_colete: numero_colete , nome_catalogo: 'Melhor Cabeça' , inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, nome_animal: competidor.inscricao.nome_animal, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 5 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 5 * 1, pontuacao: 5 * 1, animais_julgados: qtde_competidores
        else
          competidor.update posto: '', campeao: ''
        end
        position += 1
      end

    elsif competicaos_evento_id.competicao.modalidade.nome == "Melhor Aprumo"
      competidores.each do |competidor|
        if competidor.inscricao.faixa_etaria >= 36
          qtde_competidores = Inscricao.where('faixa_etaria >= 36').where(evento_id: $evento.id).count
        else
          qtde_competidores = Inscricao.where('faixa_etaria < 36').where(evento_id: $evento.id).count
        end
        catalogo_comp = Catalogo.find_by(inscricao_id: competidor.inscricao_id)
        numero_colete = catalogo_comp.numero_colete
        Premio.where("inscricaos_competicao_id = #{competidor.id} and posto like '%aprumo%'").delete_all
        if position == 1 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          @campeao = competidor.id
          competidor.update posto: 'campeão aprumo', campeao: @campeao
          Premio.create posto: 'campeão melhor aprumo', numero_colete: numero_colete ,nome_catalogo: catalogo_comp.nome_catalogo ,inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 10 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 10 * 1, pontuacao: 10 * 1, animais_julgados: qtde_competidores
        elsif position == 2 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: 'reservado aprumo', campeao: @campeao
          Premio.create posto: 'reservado melhor aprumo', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 5 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 5 * 1, pontuacao: 5 * 1, animais_julgados: qtde_competidores
        else
          competidor.update posto: '', campeao: ''
        end
        position += 1
      end

      elsif competicaos_evento_id.competicao.modalidade.nome == "Amador"
        competidores.each do |competidor|
          qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: competidor.inscricao.pelagem, marcha: competidor.inscricao.marcha).count
          catalogo_comp = Catalogo.find_by(inscricao_id: competidor.inscricao_id)
          numero_colete = catalogo_comp.numero_colete
          Premio.where("inscricaos_competicao_id = #{competidor.id} and posto like '%montaria amador%'").delete_all
          if position == 1 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
            @campeao = competidor.id
            competidor.update posto: 'campeão montaria amador', campeao: @campeao
            Premio.create posto: 'campeão melhor montaria amador', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 20 * 1, criador: competidor.inscricao.criador.nome, pontuacao_criador: 20 * 1, pontuacao: 20 * 1, animais_julgados: qtde_competidores
          elsif position == 2 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
            competidor.update posto: 'reservado montaria amador', campeao: @campeao
            Premio.create posto: 'reservado melhor montaria amador', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo, inscricao_id: competidor.inscricao_id , nome_animal: competidor.inscricao.nome_animal, inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 20 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 10 * 1, pontuacao: 10 * 1, animais_julgados: qtde_competidores
          else
            competidor.update posto: '', campeao: ''
          end
          position += 1
        end

      elsif competicaos_evento_id.competicao.modalidade.nome == "Prova Social"
        competidores.each do |competidor|
          qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: competidor.inscricao.pelagem, marcha: competidor.inscricao.marcha).count
          catalogo_comp = Catalogo.find_by(inscricao_id: competidor.inscricao_id)
          numero_colete = catalogo_comp.numero_colete
          Premio.where("inscricaos_competicao_id = #{competidor.id} and posto like '%montaria amador%'").delete_all
          if position == 1 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
            @campeao = competidor.id
            competidor.update posto: 'campeão montaria amador', campeao: @campeao
            Premio.create posto: 'campeão melhor montaria amador', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo, nome_animal: competidor.inscricao.nome_animal, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 20 * 1, criador: competidor.inscricao.criador.nome, pontuacao_criador: 20 * 1, pontuacao: 20 * 1, animais_julgados: qtde_competidores
          elsif position == 2 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
            competidor.update posto: 'reservado montaria amador', campeao: @campeao
            Premio.create posto: 'reservado melhor montaria amador', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo, nome_animal: competidor.inscricao.nome_animal, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 20 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 10 * 1, pontuacao: 10 * 1, animais_julgados: qtde_competidores
          else
            competidor.update posto: '', campeao: ''
          end
          position += 1
        end

    else
      qtde_competidores = Inscricao.where(evento_id: $evento.id, pelagem: competidores.first.inscricao.pelagem, marcha: competidores.first.inscricao.marcha).count
      competidores.each do |competidor|
        catalogo_comp = Catalogo.find_by(inscricao_id: competidor.inscricao_id)
        numero_colete = catalogo_comp.numero_colete
        Premio.where("inscricaos_competicao_id = #{competidor.id} and posto like '%convencional%'").delete_all
        if competidor.observacao_final == 'asterisco' && (position == 1 || position == 2)
          position_true = position
          position = 3
          arrumar = true
        end
        if position == 3 && arrumado == true
          position = position_arrumar
          position_arrumar += 1
        end

        
        if position == 1 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          @campeao = competidor.id
          competidor.update posto: 'campeão', campeao: @campeao
          Premio.create posto: 'campeão convencional', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo , nome_animal: competidor.inscricao.nome_animal, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 20 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 20 * 1, pontuacao: 20 * 1, animais_julgados: qtde_competidores 
        elsif position == 2 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: 'reservado', campeao: @campeao
          Premio.create posto: 'reservado convencional', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo , nome_animal: competidor.inscricao.nome_animal, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id ,  inscricao_campeao_id: @campeao, expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 15 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 15 * 1, pontuacao: 15 * 1, animais_julgados: qtde_competidores 
        elsif position == 3 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco') && arrumado != true
          competidor.update posto: '1 Premio', campeao: ''
          Premio.create posto: '1 Premio convencional', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo , nome_animal: competidor.inscricao.nome_animal, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 5 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 5 * 1, pontuacao: 5 * 1, animais_julgados: qtde_competidores 
        elsif position == 4 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: '2 Premio', campeao: ''
          Premio.create posto: '2 Premio convencional', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo , nome_animal: competidor.inscricao.nome_animal,  inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 4 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 4 * 1, pontuacao: 4 * 1, animais_julgados: qtde_competidores 
        elsif position == 5 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: '3 Premio', campeao: ''
          Premio.create posto: '3 Premio convencional', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo , nome_animal: competidor.inscricao.nome_animal, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 3 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 3 * 1, pontuacao: 3 * 1, animais_julgados: qtde_competidores 
        elsif position == 6 && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: '4 Premio', campeao: ''
          Premio.create posto: '4 Premio convencional', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo , nome_animal: competidor.inscricao.nome_animal, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 2 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 2 * 1, pontuacao: 2 * 1, animais_julgados: qtde_competidores 
        elsif position == 7  && (!competidor.observacao_final.present? || competidor.observacao_final == 'asterisco')
          competidor.update posto: '5 Premio', campeao: ''
          Premio.create posto: '5 Premio convencional', numero_colete: numero_colete , nome_catalogo: catalogo_comp.nome_catalogo , nome_animal: competidor.inscricao.nome_animal, inscricao_id: competidor.inscricao_id , inscricaos_competicao_id: competidor.id, competicaos_evento_id: competidor.competicaos_evento_id , expositor: competidor.inscricao.expositor.nome, pontuacao_expositor: 1 * 1 , criador: competidor.inscricao.criador.nome, pontuacao_criador: 1 * 1, pontuacao: 1 * 1, animais_julgados: qtde_competidores 
        else
          competidor.update posto: '', campeao: ''
        end

        if arrumar == true
          position = position_true
          arrumado = true
          arrumar = false
        else
          position += 1
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_competicao_avalicao
      @competicao_avalicao = CompeticaoAvalicao.find(params[:id])
    end

    def set_data_form
      @competicaojuris = CompeticaoJuri.joins(:competicaos_evento).where(
        competicaos_eventos: {
          evento_id: $evento.id,
          competicao_id: params[:competicao_id]
        }
      )
      @competicao_avalicaos = @competicaojuris&.map {|juri| juri.competicao_avalicaos.present? ? juri.competicao_avalicaos : CompeticaoAvalicao.new}.flatten
  
      @clusters = ClusterCriteriosAvaliacao.joins(criterios_avaliacaos: :criterios_competicaos).where(criterios_avaliacaos: {criterios_competicaos: {competicao_id: params[:competicao_id]}})
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def competicao_avalicao_params
      #params.require(:competicao_avalicao).permit(:competicao_juri_id, :criterios_competicao_id, :inscricao_id, :nota, :data)
    end

    def sort_column
      CompeticaoAvalicao.column_names.include?(params[:sort]) ? params[:sort] : "id"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
