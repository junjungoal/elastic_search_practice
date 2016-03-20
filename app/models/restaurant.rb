class Restaurant < ActiveRecord::Base
  include Tire::Model::Search
  index_name "restaurant_#{Rails.env}"
  after_save :index_update
  after_destroy :index_remove

  belongs_to :category, touch: true
  belongs_to :prefecture, touch: true

   settings do
    mappings dynamic: 'false' do # デフォルトでマッピングが自動作成されるがそれを無効にする
      indexes :name, analyzer: :kuromoji
      indexes :name_kana, analyzer: :kuromoji

      indexes :zip
      indexes :address, analyzer: :kuromoji

      indexes :closed, type: 'boolean'
      indexes :description, analyzer: :kuromoji

      indexes :created_at, type: 'date', format: 'date_time'
    end
  end
 

  def index_update
    self.index.store self
  end

  # destroy後にindexから削除
  def index_remove
    self.index.remove self
  end

  def self.search(query)
    tire.search(load: true) do
      query do
        boolean do
          should { string query } 
        end
      end if query.present?
    end
  end
end

