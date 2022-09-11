# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
    has_one_attached :eyecatch

    # titleが入力されていないと保存されない
    validates :title, presence: true
    #必要な文字数の指定
    validates :title, length: { minimum: 2, maximum: 100 }
    # 先頭の文字に「@」を入れるとエラーがバリデーションがかかる正規表現
    validates :title, format: { with: /\A(?!\@)/ }

    # contentが入力されていないと保存されない
    validates :content, presence: true
    #必要な文字数の指定
    validates :content, length: { minimum: 10 }
    #他の記事と同じ内容の場合はエラーが出るようにする
    validates :content, uniqueness: true

    #タイトルと内容が合わせて100文字以上でなければバリデーションがかかる
    validate :validate_title_and_content_length

    #記事が削除されたときにコメントも削除される
    has_many :comments, dependent: :destroy

    has_many :likes, dependent: :destroy

    #記事はユーザーと紐づいている
    belongs_to :user

    def display_created_at
        I18n.l self.created_at, format: :default
    end

    def author_name
        user.display_name
    end

    def like_count
        likes.count
    end

    private
    def validate_title_and_content_length
        #タイトルと文字数を足した数をchar_countに代入
        char_count = self.title.length + self.content.length
        #char_countが100文字以下の場合
        unless char_count > 100
            #内容にエラーが出る
            errors.add(:content, '100文字以上で入力してください')
        end
    end
end
