class RenameUrlToUrlSubdirectoryOnEvents < ActiveRecord::Migration[7.1]
  def change
    rename_column :events, :url, :url_subdirectory
  end
end
