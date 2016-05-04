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

	# @article.update_atributes({title: nuevo})

end