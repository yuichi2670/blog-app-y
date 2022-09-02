class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def create
        # データを保存する箱を作る、そこにデータを入れる
        @article = Article.new(article_params)
        # もし入れたデータを保存されていたら、作成された記事のページに遷移する
        if @article.save
            redirect_to article_path(@article), notice: '保存できたよ'
        # 保存されなければ
        else
            flash.now[:error] = '保存に失敗しました'
            render :new
        end
    end

    # formから受け取った情報（ここではtitleとcontent）を抜き出す。
    private
    def article_params
        # articleは絶対求められ、その中でtitleとcontentは許される
        params.require(:article).permit(:title, :content)
    end
end