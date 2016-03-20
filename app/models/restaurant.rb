class Restaurant < ActiveRecord::Base
  include Tire::Model::Search
  index_name "restaurant_#{Rails.env}"
  after_save :index_update
  after_destroy :index_remove

   settings do
    mappings dynamic: 'false' do # デフォルトでマッピングが自動作成されるがそれを無効にする
      indexes :name, analyzer: :kuromoji
      indexes :name_kana, analyzer: :kuromoji

      indexes :zip
      indexes :address, analyzer: :kuromoji
      indexes :description, analyzer: :kuromoji
    end
  end
 

  def index_update
    self.index.store self
  end

  # destroy後にindexから削除
  def index_remove
    self.index.remove self
  end

  def self.search(keyword)
    tire.search(load: true) do
      query do
        string keyword
      end if keyword.present?
    end
  end
end

