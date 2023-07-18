class TermsController < ApplicationController
  skip_before_action :authenticate_user!
    
    def document
      send_file(Rails.root.join("public", "documentos", "inscricao_termo.pdf").to_s,
      :disposition => "inline", :type => "application/pdf")
    end

  end
  