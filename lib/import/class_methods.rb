module Import
  module ClassMethods

    def self.included(base)
      base.extend(ClassMethods)
    end

    require "axlsx"
    require "roo"

    attr_accessor :file
    attr_reader :columns

    def process_data
      file = self.open_file(@file)
      header = file.row(1).map { |i| i.parameterize }
      @columns = self.class.columns

      (2..file.last_row).each do |i|
        row = Hash[[header, file.row(i)].transpose]
        data = {}
        ret = {}
        @columns.each do |column_key, column_config|
          value_column = row[column_config[:row_name].parameterize]
          is_required = column_config.keys.include?(:required) ? column_config[:required] : true

          data_column = column_config[:value] ? column_config[:value].call(value_column) : value_column
          data[column_key] = data_column
          valid_column = valid?(data_column, column_config[:validate], is_required)
          ret[column_key] = {
            valid: !!valid_column,
            value: data_column,
            raw_value: value_column,
            column_name: column_config[:row_name],
            error: "Está em branco ou não é valido",
          }
        end
        not_vali = ret.find { |k, v| !v[:valid] }
        not_vali ? invalid_record(ret, file.last_row - 1, i) : valid_record(data, file.last_row - 1, i)
      end
    end

    # Função de atribuição dos campos com os devidos dados
    def set_column(column, *data)
      @columns ||= {}
      @columns[column] = data.first
    end
    

    def valid?(data, type, required)
      case type
      when Proc then data.present? ? !!type.call(data) : !required
      when :numeric then data.present? ? data.is_a?(Numeric) : !required
      when :string then data.present? ? data.is_a?(String) : !required
      when :date then data.present? ? float_to_date(data) : !required
      when :datetime then data.present? ? float_to_date(data) : !required
      else (!required || data.present?)
      end
    end

    def float_to_date(date)
      if date.is_a?(Numeric)
        Time.at((date - 25568).days)
      else
        date.to_datetime rescue false
      end
    end

    def row_indexer(i)
      i > 25 ? "A#{(65 + i % 26).chr}" : (65 + i).chr
    end

    def open_file(file)
      case File.extname(file)&.downcase
      when ".csv" then Roo::Csv.new(file, options = {})
      when ".xls" then Roo::Excel.new(file, options = {})
      when ".xlsx" then Roo::Excelx.new(file, options = {})
      else raise "Tipo de arquivo não suportado: #{file.original_filename}"
      end
    end
  end
end
