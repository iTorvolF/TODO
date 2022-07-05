module Services
  class UsersReport
    def self.call(*args)
      new.call(*args)
    end

    def call(from, to)
      package = Axlsx::Package.new
      workbook = package.workbook
      sheet = workbook.add_worksheet(name: 'Пользователи')

      scope(from, to).find_each do |user|
        sheet.add_row [user.name, user.events.size, user.items.size]
      end

      package.to_stream.read
    end

    private

    def scope(from, to)
      scope = User.includes(events: :items).order(:name)
      scope = scope.where(created_at: from..to) if from || to
      scope
    end
  end
end