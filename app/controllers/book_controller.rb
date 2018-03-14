class BookController < ApplicationController

  #-----------------リンク前の処理-----------------#
  before_action :authenticate_user!, only: [:notice, :detail, :show, :wantBook, :inquiry, :user]

  before_action :admin_user, {only: [:notice, :detail]}


  #-----------------ページわけの値-----------------#
  PER = 20


  #-----------------ホーム-----------------#
  def index
    @books = Book.order('updated_at').page(params[:page]).per(PER)
    @notices = Notice.where(read: false)
  end


  #-----------------お知らせ-----------------#
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


  #-----------------検索-----------------#
  def search
    search = params[:search]
    @books = Book.where("title ilike ?", "%#{search}%").or(
    Book.where("author ilike ?", "%#{search}%")).or(
    Book.where("publisher ilike ?", "%#{search}%")).or(
    Book.where("genre ilike ?", "%#{search}%"))
  end


  #-----------------本関連-----------------#
  def show
    if @book = Book.find_by(id: params[:id]) != nil
      @book = Book.find_by(id: params[:id])
      begin
        @books = Book.where(rental_user: current_user.email)
      rescue => e
        flash[:notice] ="ログインしてください"
        redirect_to("/")
      end
    else
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


  #-----------------購入申請-----------------#
  def wantBook
  end

  def url
      type = "購入申請"
      @notice = Notice.new(
        title: type,
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


  #-----------------問い合わせ-----------------#
  def inquiry
  end

  def demand
    type = "問い合わせ"
    @notice = Notice.new(
      title: type,
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


  #-----------------ユーザ-----------------#
  def user
    @books = Book.where(rental_user: current_user.email)
  end


  #-----------------管理者権限フィルタ-----------------#
  def admin_user
    if user_signed_in?
      if !current_user.admin_flg
        flash[:notice] = "権限がありません"
        redirect_to "/"
      end
    else
      flash[:notice] = "ログインしてください"
      redirect_to "/"
    end
  end

end
