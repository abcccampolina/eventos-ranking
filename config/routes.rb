Rails.application.routes.draw do
  default_url_options(**Rails.application.config.action_mailer.default_url_options) if Rails.application.config.action_mailer.default_url_options.present?
  
  get 'srg_animals' => "srg_animals#index", defaults: {format: :json}
  get "procurar_expositor" => "pessoas#procurar_expositor"

  get 'imprimir_parcial_notas/index'
  get 'sumula/index'
  resources :catalogos
  resources :catalogo_competicaos
  resources :catalogo_nomes
  get 'relatorio/index'
  get 'ranking/index'
  get 'ranking/bi'

  resources :competicao_desempates
  get 'configuracao/index'
  resources :competicao_avalicaos
  controller :competicao_avalicaos do
    match 'competicao_avalicaos/set_juri_desempate', via: :post, action: :set_juri_desempate
  end
  resources :competicao_juris
  resources :criterios_competicaos
  resources :criterios_avaliacaos
  resources :cluster_criterios_avaliacaos
  get 'inscritos_competicao/index'
  resources :competicaos_eventos
  resources :parametro_inscricaos
  resources :inscricaos_competicaos
  resources :inscricaos
  resources :competicaos
  resources :eventos
  resources :modalidades
  resources :pessoas
  resources :premios
  resources :manage_users
  resources :srg_animals
  resources :srg_pessoas

  devise_for :users
  get "dashboard/index"
  root "dashboard#index"

  get '/s/:slug', to: 'links#show', as: :short

  get 'buscar_numero_registro_srg' => 'inscricaos#buscarSrg'
  get 'buscar_animal_srg_por_cpf' => 'inscricaos#buscarAnimalPorCPF'

  get 'encerrar_secao_cpf' => 'inscricaos#encerrar_secao_cpf'
  
  get 'buscar_progenie_srg' => 'inscricaos_competicaos#buscar_progenie'
  get 'buscar_casalamento_srg' => 'inscricaos_competicaos#buscar_casalamento'

  get 'gerar_catalogo' => 'catalogos#gerar'
  get 'inscritos_competicao/change_cluster' => 'inscritos_competicao#change_cluster'

  
  get 'relatorio/animais_expositor' => 'relatorio#animais_expositor', as: :relatorio_animais_expositor
  get 'relatorio/animais_competicoes' => 'relatorio#animais_competicoes', as: :relatorio_animais_competicoes
  get 'relatorio/sugestao_progenie' => 'relatorio#sugestao_progenie', as: :relatorio_sugestao_progenie
  get 'relatorio/mapa_campeoes' => 'relatorio#mapa_campeoes', as: :relatorio_mapa_campeoes
  get 'relatorio/gerar_campolina_completo' => 'relatorio#gerar_campolina_completo', as: :gerar_campolina_completo
  get 'relatorio/animais_uf' => 'relatorio#animais_uf', as: :animais_uf

  get 'inscricaos_competicao/nova_inscricao' => 'inscricaos_competicaos#nova_inscricao'
  get 'gerar_inscritos' => 'competicaos_eventos#gerar_inscritos'
  get 'ajutar_nota' => 'competicao_avalicaos#ajuste_nota'

  get 'ajutar_nota_marchador' => 'competicao_avalicaos#ajuste_nota_marchador'

  get 'gerar_ranking' => 'ranking#gerar_ranking'
  get 'imprimir_parcial' => 'competicao_avalicaos#imprimir_parcial'
  get 'imprimir_resultado' => 'competicao_avalicaos#imprimir_resultado'
  get 'gerar_qtd_categorias' => 'competicaos_eventos#gerar_qtd_categorias'

  get  'ajustar_faixa_etaria' => 'inscricaos#ajustar_faixa_etaria', as: :ajustar_faixa_etaria
  get 'inscricao/confirmacao_inscricao_mailer' => 'inscricaos#confirmacao_inscricao_mailer', as: :confirmacao_inscricao_mailer
  get  'confirmar_presenca' => 'inscricaos#confirmar_presenca', as: :confirmar_presenca
  get  'lista_confirmacao/:id' => 'inscricaos#lista_confirmacao', as: :lista_confirmacao
  post 'presenca_confirmada/:id' => 'inscricaos#presenca_confirmada', as: :presenca_confirmada

  get 'documentos/inscricao_termo' => 'terms#document'
  
  # Rota responsável por abrir a documentação de ajuda do sistema
  get 'documentos/dh_intro_about' => 'documentos#index'

  get 'detalhe_ranking_criador' => 'ranking#detalhe_ranking_criador'
  get 'detalhe_ranking_expositor' => 'ranking#detalhe_ranking_expositor'
  get 'ranking_picada' => 'ranking#ranking_picada'
  get 'ranking_batida' => 'ranking#ranking_batida'
  get 'ranking_animal' => 'ranking#ranking_animal'
  get 'detalhe_ranking_animal' => 'ranking#detalhe_ranking_animal'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
