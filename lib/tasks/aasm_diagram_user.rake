if Rails.env.development?
  namespace :aasm_diagram do
    desc 'generate diagrams'
    task user: :environment do
      AASMDiagram::Diagram.new(User.new.aasm, 'tmp/user.png')
      puts 'Diagram created in tmp/user.png'
    end
  end
end