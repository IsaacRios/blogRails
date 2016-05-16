class ArticlesController < ApplicationController
	#GET / articles
	def index
		@articles = Article.all
	end

	#GET /articles/:id
	def show
		#encontrar un registro por Id
		@article = Article.find(params[:id])
		#WHERE
		Article.where.not("id = ?",params[:id])
	end

	#GET /articles/new
	def new
		#no se guarda en base de datos, sólo en memoría
		@article = Article.new
	end

	def edit
		@article = Article.find(params[:id])
	end

	#POST /articles
	def create
		@article = Article.new(title: params[:article][:title], body: params[:article][:body])
		if @article.save
			redirect_to @article
		else
			render :new
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy #Destroy elimina el objeto de la base de datos
		redirect_to articles_path
	end

	#PUT /articles/:id
	def update
		#UPDATE
		#@article.update_attributes({title: 'Nuevo título'})
		@article = Article.find(params[:id])
		if @article.update(article_params)
			redirect_to @article
		else
			render :edit
		end
	end

	private

	def article_params
		params.require(:article).permit(:title, :body)
	end

end