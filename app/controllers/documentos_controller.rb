class DocumentosController < ApplicationController
  before_action :authenticate_user!

  def index
    render file: "#{Rails.root}/documentos/dh_intro_about.html", layout: false, template: false
  end
end
