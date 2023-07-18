module ApplicationHelper
  def menu_name(menu, default)
    #current_name = @organization&.menu_names&.dig(menu)
    current_name.present? ? current_name : default
  end

  def icon_valid_tag(valid)
    valid ? content_tag(:i, nil, class: "fas fa-check text-success") : content_tag(:i, nil, class: "fas fa-times text-danger")
  end

  def distance_months_and_days(start_date, today)

    total_days_difference = (today - start_date).to_i
    months_difference = total_days_difference / 30
    days_difference = total_days_difference % 30

    return months_difference, days_difference
  end

  def get_time_in_words(start_date, today=Date.today)
    rest = distance_months_and_days(start_date, today)
    "#{rest.first} #{ "mês".pluralize(rest.first) } e #{rest.last} #{ "dia".pluralize(rest.last) }"
  end

  def to_word_md(month, day)
    "#{month} #{ "mês".pluralize(month) } e #{day} #{ "dia".pluralize(day) }"
  end

  def montar_fazenda_expositor(expositor)
    "#{expositor.fazenda}, #{expositor.cidade} - #{expositor.uf}"
  end

  def gerar_catalogo(comp_evento)

    if comp_evento.present?
      competicoes_evento = CompeticaosEvento.where(id: comp_evento).order('ordem')
    else
      competicoes_evento = CompeticaosEvento.where(evento_id: $evento.id).order('ordem')
    end
  
    Catalogo.where(competicaos_evento_id: competicoes_evento.ids).destroy_all rescue nil
    CatalogoCompeticaos.where(evento_id: $evento.id).destroy_all rescue nil

    competicoes_evento.each do |comp|
      #Obter inscritos da competição
      inscritos = InscricaosCompeticao.joins("INNER JOIN inscricaos ON inscricaos_competicaos.inscricao_id =  inscricaos.id").where(competicaos_evento_id: comp.id).order("inscricaos.faixa_etaria").order("inscricaos.faixa_etaria_dia")
      inscritos_so_marcha = Inscricao.where(so_marcha: true, id: inscritos.pluck(:inscricao_id)).order('faixa_etaria').order("faixa_etaria_dia")
      
      #Remover os inscritos só marcha
      if inscritos_so_marcha.present?
        inscritos = inscritos.where.not(inscricao_id:inscritos_so_marcha.ids)
      end
      
      #Numero inscrito na convencional
      numero_inscrito = inscritos.count rescue nil
      qtd_cat = CatalogoCompeticao.where("competicaos_evento_id = #{comp.id} and (qtd_inscritos <= #{numero_inscrito} and qtd_inscritos_fim >= #{numero_inscrito})").first.qtd_catalogos rescue nil
      
      cada_catalogo_contador = (numero_inscrito / qtd_cat.to_f).to_f rescue nil
      
      #gera o catalogo dos animais convencionais.
      if numero_inscrito.present? && numero_inscrito&.to_f > 0 && qtd_cat.present? && qtd_cat&.to_f > 0
        contador = 1
        cat_num = 1

        inscritos&.in_groups(qtd_cat&.to_i, false)&.each do |inscrito|
          inscrito.each do |inscritinho|
            nome_catalogo = CatalogoNome.where("ordem_nome = #{cat_num} and competicaos_evento_id = #{comp.id}").first
            @catalogo = Catalogo.new(inscricao_id: inscritinho.inscricao_id , nome_catalogo: nome_catalogo&.nome, catalogo_nome_id: nome_catalogo&.id, competicaos_evento_id: comp&.id)
            @catalogo.save

            # contador.to_f >= cada_catalogo_contador.to_f
            #   cat_num += 1
            #   contador = 1
            # else
            #   contador += 1
            # end
          end
          cat_num += 1
        end
      end

      #Adiciona o animal so marcha posteriormente ao catalogo
      if inscritos_so_marcha.present?
        numero_inscrito_so_marcha = inscritos_so_marcha.count rescue nil
        cada_catalogo_contador_so_marcha = (numero_inscrito_so_marcha / qtd_cat.to_f).to_f rescue nil
        contador = 1
        cat_num = 1

        #inscritos_so_marcha = inscritos_so_marcha.in_groups(qtd_cat, false) rescue nil

        if qtd_cat&.to_f > 0 
          inscritos_so_marcha&.in_groups(qtd_cat&.to_i, false)&.each do |so_marcha|
            so_marcha.each do |so_marchinha|
              nome_catalogo = CatalogoNome.where("ordem_nome = #{cat_num} and competicaos_evento_id = #{comp.id}").first
              @catalogo = Catalogo.new(inscricao_id: so_marchinha.id , nome_catalogo: nome_catalogo&.nome, catalogo_nome_id: nome_catalogo&.id, competicaos_evento_id: comp&.id)
              @catalogo.save

              # // contador.to_f >= cada_catalogo_contador_so_marcha.to_f
              # //  cat_num += 1
              # //  contador = 1
              # // else
              # //  contador += 1
              # // end
            end
            cat_num += 1
          end
        end
      end
    end

    catalogos = Catalogo.joins("INNER JOIN inscricaos ON catalogos.inscricao_id = inscricaos.id 
                                INNER JOIN competicaos_eventos on catalogos.competicaos_evento_id = competicaos_eventos.id
                                INNER JOIN catalogo_nomes on catalogos.catalogo_nome_id = catalogo_nomes.id")
    .where(competicaos_evento_id: competicoes_evento.ids)
    .order('competicaos_eventos.ordem', :ordem_nome)
    .order("inscricaos.faixa_etaria")
    .order("inscricaos.faixa_etaria_dia")
    
    comps_evet  = CompeticaosEvento.where(evento_id: $evento.id).order('ordem')
    @numero_colete = Catalogo.where(competicaos_evento_id: comps_evet.ids).maximum('numero_colete') + 1 rescue 1

    #Inicio Geração da numeração do catalogo
      catalogos.each do |catalogo|

          if catalogo.competicaos_evento.competicao.modalidade.nome == "Competição Progênie"
            group_number = InscricaosCompeticao.find_by(inscricao_id: catalogo.inscricao_id, competicaos_evento_id: catalogo.competicaos_evento_id)
            group = InscricaosCompeticao.where(grupo_progenie: group_number.grupo_progenie, acasalamento_mae_id: nil, evento_id: $evento.id)
            
            @numero_colete_progenie = Catalogo.where(competicaos_evento_id: comps_evet.ids).maximum('numero_colete_progenie') + 1 rescue @numero_colete

            group.each do |g|
              cat_group = Catalogo.find_by(inscricao_id: g.inscricao_id, competicaos_evento_id: g.competicaos_evento_id)
              if !cat_group.numero_colete_progenie.present?
                cat_group.update numero_colete_progenie: @numero_colete_progenie
              end
            end
            @numero_colete += 1
          end

          if catalogo.competicaos_evento.competicao.modalidade.nome == "Competição Acasalamento"
            group_number = InscricaosCompeticao.find_by(inscricao_id: catalogo.inscricao_id, competicaos_evento_id: catalogo.competicaos_evento_id)
            group = InscricaosCompeticao.where(grupo_progenie: group_number.grupo_progenie, evento_id: $evento.id).where.not(acasalamento_mae_id: nil)

            @numero_colete_progenie = Catalogo.where(competicaos_evento_id: comps_evet.ids).maximum('numero_colete_progenie') + 1 rescue @numero_colete
            if @numero_colete_progenie == 1
              @numero_colete_progenie = @numero_colete
            end
            group.each do |g|
              cat_group = Catalogo.find_by(inscricao_id: g.inscricao_id, competicaos_evento_id: g.competicaos_evento_id)
              if !cat_group.numero_colete_progenie.present?
                cat_group.update numero_colete_progenie: @numero_colete_progenie
              end
            end
            @numero_colete += 1
          end
          

          check_numero = Catalogo.where(inscricao_id: catalogo.inscricao_id).first
          if check_numero.numero_colete.present?
            catalogo.update numero_colete: check_numero.numero_colete
          else
            catalogo.update numero_colete: @numero_colete
            @numero_colete += 1
          end
      end
    #Fim Geração da numeração do catalogo
  end

  def link_to_add_template_fields(name, path, action=nil)
    fields = render(path)
    link_to(name.html_safe, '#', class: "add_template_fields", data: {fields: fields.split("\n").map(&:strip).join(''), action: action})
  end

end