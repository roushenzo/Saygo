ActiveAdmin.register Page do
  form do |f|
    f.inputs "General info" do
      f.input :url, :as => :url
      f.input :title
      f.input :description
      f.input :country, :as => :string
      f.input :city
      f.input :category, :as => :select
    end

    f.inputs :meta_title, :meta_keys, :meta_description, :name => "Meta tags"

    f.has_many :images do |fi|
      fi.input :file_cache, :as => :hidden
      fi.input :file, :as => :file
      fi.input :remote_file_url, :as => :url
    end

    f.buttons
  end
end
