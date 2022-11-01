module Services
  module Users
    module Download
      class UsersDownload
        def self.call(*args)
          new.call(*args)
        end

        def call
          package, sheet = excel_create

          scope.find_each do |user|
            sheet.add_row [user.id, user.name, user.email, user.role.code]
          end

          package.to_stream.read
        end

        private

        def excel_create
          package = Axlsx::Package.new
          workbook = package.workbook
          sheet = workbook.add_worksheet(name: 'Пользователи')

          [package, sheet]
        end

        def scope
          User.includes(:role).order(:id)
        end
      end
    end
  end
end
