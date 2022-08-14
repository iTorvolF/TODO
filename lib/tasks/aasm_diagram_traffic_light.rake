if Rails.env.development?
  namespace :aasm_diagram do
    desc 'generate diagrams'
    task traffic_light: :environment do
      AASMDiagram::Diagram.new(TrafficLight.new.aasm, 'tmp/traffic_light.png')
      puts 'Diagram created in tmp/traffic_light.png'
    end
  end
end
