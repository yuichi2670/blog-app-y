class Article < ApplicationRecord
    # titleが入力されていないと保存されない
    validates :title, presence: true
    # contentが入力されていないと保存されない
    validates :content, presence: true


    def display_created_at
        I18n.l self.created_at, format: :default
    end
end
