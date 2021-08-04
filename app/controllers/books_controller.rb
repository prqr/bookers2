class BooksController < ApplicationController

  def top

  end

  def index
   @books = Book.all
    @users = User.all
    @user = current_user
    @book = Book.new
  end

  def show
   @book = Book.find(params[:id])
   @book_comment = BookComment.new
   @newbook = Book.new
   @users = User.all
   @user = @book.user
  end


  def new
   @book = Book.new

  end


  def edit
   @book = Book.find(params[:id])
   unless @book.user.id == current_user.id
    redirect_to books_path

   end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id)
      flash[:notice] = "successfully"
    else
      @books = Book.all
      @user = current_user
     render :index
    end

  end

   def update
       @book = Book.find(params[:id])
       if @book.update(book_params)
      redirect_to book_path(@book.id)
      flash[:notice] = "successfully"
       else
         render :edit
       end

   end


   def destroy
    
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path

   end

  private

  def book_params
    params.require(:book).permit(:title, :body)

  end
end
