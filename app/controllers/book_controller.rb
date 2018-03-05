class BookController < ApplicationController
  def index
    @books = Book.all
    @notices = Notice.where(read: false)
  end

  def notice
    @notices = Notice.where(read: false)
  end

  def detail
    @notice = Notice.find_by(id: params[:id])
  end

  def read
    @notice = Notice.find_by(id: params[:id])
    @notice.read = true
    @notice.save
    redirect_to "/notice"
  end

  def search
    search = params[:search]
    @books = Book.where("title like '%"+ search + "%' ").or(
    Book.where("author like '%"+ search + "%' ")).or(
    Book.where("publisher like '%"+ search + "%' ")).or(
    Book.where("genre like '%"+ search + "%' "))
  end

  def show
    @book = Book.find_by(id: params[:id])
    begin
      @books = Book.where(rental_user: current_user.email)
    rescue => e
      flash[:notice] ="ログインしてください"
      redirect_to("/")
    end
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
      @type = "購入申請"
      @notice = Notice.new(
        title: @type,
        body: params[:amazonurl],
        sender: current_user.id,
        read: false
      )
    if @notice.save
      redirect_to "/"
    else
      render("wantBook")
    end
  end

  def inquiry
  end

  def demand
    @type = "問い合わせ"
    @notice = Notice.new(
      title: @type,
      body: params[:body],
      sender: current_user.id,
      read: false
    )
    if @notice.save
      redirect_to "/"
    else
      render("inquiry")
    end
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
