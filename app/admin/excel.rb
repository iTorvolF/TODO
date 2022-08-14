require 'axlsx'

ActiveAdmin.register_page 'Excel' do
  menu priority: 5

  action_item :excel do
    link_to 'Скачать', admin_excel_excel_path, method: :post
  end

  page_action :excel, method: :post do
    package = Axlsx::Package.new
    workbook = package.workbook

    first = workbook.add_worksheet(name: 'task1')
    first.add_row %w[value result]
    (-5..5).each_with_index do |value, index|
      first.add_row [value, "=POWER(A#{index + 2},2)"]
    end

    second = workbook.add_worksheet(name: 'task7')
    second.add_chart(Axlsx::Pie3DChart, start_at: 'C10', end_at: 'K20', title: 'Задание 7') do |chart|
      chart.add_series data: first['A2:A12'], title: first['A1'], colors: ['FF0000']
      chart.add_series data: first['B2:B12'], title: first['B1'], colors: ['00FF00']
    end

    send_data package.to_stream.read,
              type: 'application/octet-stream',
              filename: 'task1_7.xlsx'
  end
end
