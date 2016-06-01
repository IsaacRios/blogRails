class ArticlesController < ApplicationController
	before_action :authenticate_user!, except: [:show,:index]
	before_action :set_article, except: [:index,:new, :create]
	#GET / articles
	def index
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		@article.update_visits_count
		@Comment = Comment.new
	end

	#GET /articles/new
	def new
		#no se guarda en base de datos, sólo en memoría
		@article = Article.new
	end

	def edit
	end

	#POST /articles
	def create
#		@article = Article.new(title: params[:article][:title], body: params[:article][:body])
		@article = current_user.articles.new(article_params)
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	#DELETE /articles/:id
	def destroy
		#DELETE FROM articles
		@article.destroy #Destroy elimina el objeto de la base de datos
		redirect_to articles_path
	end

	#PUT /articles/:id
	def update

		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	private

	def set_article
		@article = Article.find(params[:id])
	end

	def validate_user
		redirect_to new_user_session_path, notice: "Necesitas iniciar sesión"
	end

	def article_params
		params.require(:article).permit(:title, :body)
	end

end