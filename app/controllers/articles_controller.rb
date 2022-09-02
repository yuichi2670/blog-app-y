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

    def edit
        # urlのIDを取得。viewのarticleに渡す
        @article = Article.find(params[:id])
    end

    def update
        @article = Article.find(params[:id])
        # もし入れたデータを更新されていたら、更新された記事のページに遷移する
        if @article.update(article_params)
            redirect_to article_path(@article), notice: '更新できました'
        # 保存されなければ編集画面に戻る
        else
            flash.now[:error] = '更新に失敗しました'
            render :edit
        end
    end

    # formから受け取った情報（ここではtitleとcontent）を抜き出す。
    private
    def article_params
        # articleは絶対求められ、その中でtitleとcontentは許される
        params.require(:article).permit(:title, :content)
    end
end