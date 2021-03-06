module JlsApi
  class InstallGenerator < Rails::Generators::Base
    def create_files_and_directories
      (Dir['config/environments/*.rb'] + ["config/application.rb"]).each do |file_path|
        gsub_file file_path, "config.eager_load = false", "config.eager_load = true"
      end

      gsub_file "config/routes.rb", "Rails.application.routes.draw do", <<-CONTENT
Rails.application.routes.draw do
  # JLS:API router invocation
  jls_api :v1
      CONTENT
      create_file "app/api/v1/models/.keep", ""
      create_file "app/api/v1/routes/default.yml", <<-CONTENT
actions:
  - index
  - create
  - show
  - update
  - destroy
index:
  paginatable: true
      CONTENT
    end
  end
end
