class ArticlesController < ApplicationController
    before_action :get_article_id, only: [:show, :update, :destroy]
    def show
    end
    
    def index
        @articles = Article.all    
    end

    def new
        @article = Article.new
    end

    def create
        @article = Article.new(params_titile_and_description)
        @article.user = User.first
        if @article.save
            flash[:notice] = "Article was created successfully"
            redirect_to @article
        else 
            render 'new'
        end
    end

    def edit
        @article = Article.find(params[:id])   
    end

    def update
        if @article.update(params_titile_and_description)
            flash[:notice] = "Article was updated successfully"
            redirect_to @article
        else
            render 'edit'
        end
    end
    
    def destroy
        @article.destroy
        redirect_to articles_path
    end

    private

    def get_article_id
        @article = Article.find(params[:id])
    end

    def params_titile_and_description
        params.require(:article).permit(:title, :description)
    end

end