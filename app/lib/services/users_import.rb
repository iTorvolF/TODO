module Services
  class UsersImport
    def self.call(*args)
      new.call(*args)
    end

    def call(file_path)
      xlsx = Roo::Spreadsheet.open(file_path, extension: :xlsx)
      xlsx.default_sheet = xlsx.sheets.first

      roles = Role.all.map { |role| [role.code, role.id] }.to_h

      xlsx.each_row_streaming(pad_cells: true).each do |row|
        id, name, email, code, delete = parse_params(row)
        if id.zero? 
          create(name, email, roles[code])
        end
        delete if delete == 'delete'
        update(name, email, roles[code])
      end
    end

    private

    def create(name, email, role)
      new_user =
        {
          name: name,
          email: email,
          password: 123456,
          role_id: role,
        }
      User.create! new_user
    end

    def delete
      User.find(id).destroy
    end

    def update(name, email, role)
      User.find_by(email: email).update(name: name, email: email, role_id: role)
    end

    def parse_params(row)
      array = []
      row[0].nil? ?  array.push(0)  : array.push(row[0].value.to_i)
      row[1].nil? ?  array.push('') : array.push(row[1].value)
      row[2].nil? ?  array.push('') : array.push(row[2].value)
      row[3].nil? ?  array.push('') : array.push(row[3].value)
      row[4].nil? ?  array.push('') : array.push(row[4].value)
      array
    end
  end
end