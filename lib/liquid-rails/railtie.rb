module Liquid
  module Rails
    class Railtie < ::Rails::Railtie
      config.app_generators.template_engine :liquid

      puts "liquid-rails: Railtie"
      initializer 'liquid-rails.register_template_handler' do |app|
        puts "initializer"
        ActiveSupport.on_load(:action_view) do
          puts "on_load"
          ActionView::Template.register_template_handler(:liquid, Liquid::Rails::TemplateHandler)
        end
      end

      initializer 'liquid-rails.setup_drop' do |app|
        [:active_record, :mongoid].each do |orm|
          ActiveSupport.on_load orm do
            Liquid::Rails.setup_drop self
          end
        end
      end
    end
  end
end
