class ClientDatatable < AjaxDatatablesRails::ActiveRecord
  extend Forwardable

  def_delegators :@view, :check_box_tag, :link_to, :number_to_currency, :content_tag, :edit_client_path, :clients_path, :current_user, :view_context, :can?

  def initialize(params, opts = {})
    @view = opts[:view_context]
    super
  end
  
  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id:           { source: "Client.id" },
      first_name:   { source: "Client.first_name", cond: :like },
      last_name:    { source: "Client.last_name", cond: :like },
      cpf:          { source: "Client.cpf", cond: :like },
      email:        { source: "Client.email", cond: :like },
      phone:        { source: "Client.phone", cond: :like },
      telephone:    { source: "Client.telephone", cond: :like },
      birthday:     { source: "Client.birthday", cond: :like },
      cep:          { source: "Client.cep", cond: :like },
      address:      { source: "Client.address", cond: :like },
      number:       { source: "Client.number" },
      complement:   { source: "Client.complement" },
      neighborhood: { source: "Client.neighborhood", cond: :like },
      city:         { source: "Client.city", cond: :like },
      state:        { source: "Client.state", cond: :like },
      # name: { source: "User.name", cond: :like }
    }
  end

  def data
    records.map do |record|
      {
        full_name: link_to(record.full_name, record),
        cpf: record.cpf,
        email: record.email,
        phone: record.phone,
        city: record.city,
        state: record.state,
        acoes: content_tag(:div) do
            links = []
            links << link_to(edit_client_path(record), class: "btn btn-icona btn-neutral btn-info btn-sm") do
                content_tag(:i, nil, class: "fas fa-pen")
            end if can? :update, record

            links << link_to("javascript:void(0);", 'data-clients-id': record.id, "data-action": "clients#delete", class: "btn btn-icona btn-neutral btn-danger btn-sm delete") do
              content_tag(:i, nil, class: "fas fa-trash")
            end if can? :destroy, record
            links.join.html_safe
        end,
        id: record.id,
        first_name: record.first_name,
        last_name: record.last_name,

        telephone: record.telephone,
        birthday: record.birthday,
        cep: record.cep,
        address: record.address,
        number: record.number,
        complement: record.complement,
        neighborhood: record.neighborhood,
      }
    end
  end

  def clients
    @clients ||= options[:clients]
  end

  def get_raw_records
    clients
  end

end
