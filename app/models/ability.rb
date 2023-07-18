# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    user ||= User.new

    if user.tipo_usuario == 'Juri'
      can :lancar_notas, User, id: user.id
      can :crud, CompeticaoAvalicao
      can :read, Inscricao
    else
      can :manage, :all
    end
  end
end