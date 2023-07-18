class SrgRegistro < ApplicationRecord
    connects_to database: { writing: :sec, reading: :sec_replica }
    self.table_name = "srg_registro"
end