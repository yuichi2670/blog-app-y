class Article < ApplicationRecord
    # titleが入力されていないと保存されない
    validates :title, presence: true
    # contentが入力されていないと保存されない
    validates :content, presence: true
end
