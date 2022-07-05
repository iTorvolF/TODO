module Services
  class UsersImport
    def self.call(*args)
      new.call(*args)
    end

    def call(file_path)
      xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
      xlsx.default_sheet = xlsx.sheets.first

      roles = Role.all.map { |role| [role.code, role.id] }.to_h

      # pad_cells = true - учитывать пустые ячейки
      xlsx.each_row_streaming(pad_cells: true).each do |row|
        id, name, email, code = parse_params(row)
        User.find(id).update(name: name, email: email, role_id: roles[code])
      end
    end

    private

    def parse_params(row)
      [
        row[0].value.to_i, # id
        row[1].value,      # name
        row[2].value,      # email
        # row[3].value       # code
      ]
    end
  end
end