# README

#Gerar migrations para database principal 

rails g migration AddSrgAnimalsToInscricao srg_animal_id --database primary
bundle exec rake db:migrate

### Corrigir erro css e js
mina production deploy

./bin/webpack

### CORREÇÕES NECESSÁRIAS
. Aplicar os juris nas competições não está com o funcionamento correto
. 

# TODO
. Fazer um link externo para fazer a inscrição das progênies e filtrar a caixa
. Fazer a divisão de progênie.
. Link externo de inscrição.
. Sempre vir na impressão parcial morfologia, marcha.
. Verificar o -1 no Total ao imprimir as notas parciais de marcha no campeonato com apenas um juiz.
. Prova Funcional ao editar não traz o tempo que foi executado anteriormente.
. Ao clicar no label do melhor cabeça / melhor aprumo ele desmarca o atual e sempre marca o primeiro.
. Na hora de imprimir mostrar o total de faltas da prova funcional.
. Mapa dos campões *sem morfologia*. Voltando apenas o Campeão e reservado da categoria e campeão e reservado de marcha.
. Mapa dos campeões organizado com campeão e reservado logo em seguida.

GRANDE DA RAÇA
. Remover do lançamento de notas de morfologia os animais que só foi campeão e reservado de marcha.
. Os animais que participarão do Grande é apenas os campeões de morfologia, marcha e categoria.
. VISUALIZAR O ERRO DO LANÇAMENTO DO GRANDE CAMPEÃO QUE ESTÁ NO PRINT.


# BUGS
. Ao lançar o melhor cabeça em morfologia para um único jurado, não está aparecendo na nota final.