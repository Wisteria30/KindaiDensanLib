class BookController < ApplicationController
  def index
    @books = Book.all
  end

  def sorted
    
  end

  def show
    @book = Book.find_by(id: params[:id])
  end

  def rental
    @book = Book.find_by(id: params[:id])
    @book.status = false
    @book.rental_user = current_user.email
    if @book.save
      flash[:notice] = "貸し出しました"
      redirect_to("/")
    else
      render("#{@book.id}")
    end
  end

  def wantBook
  end

  def url
    flash[:notice] = "#{params[:amazonurl]}"
    redirect_to "/"
  end

  def user
    @books = Book.where(rental_user: current_user.email)
  end

  def return
    @book = Book.find_by(id: params[:id])
    @book.status = true
    @book.rental_user = nil
    if @book.save
      flash[:notice] = "返却しました"
      redirect_to("/#{session[:rental_user]}/user")
    else
      render("#{@current_user.id}")
    end
  end
end
