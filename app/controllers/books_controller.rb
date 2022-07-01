class BooksController < ApplicationController
  before_action :set_book, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: [:index, :show]

  # GET /books or /books.json
  def index
    @books = Book.all
    @users = User.all
    @libraries = Library.all
  end

  # GET /books/1 or /books/1.json
  def show
    @users = User.all
    @books = Book.all
    @libraries = Library.all
  end

  # GET /books/new
  def new
    @book = Book.new
    @users = User.all
    @libraries = Library.all
  end

  # GET /books/1/edit
  def edit
    @users = User.all
    @libraries = Library.all
  end

  def uplibrary
    @books = Book.all
    @users = User.all
    @libraries = Library.all
    bookid = params[:book]
    libraryid = params[:library]
  end
  # POST /books or /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to book_url(@book), notice: "Book was Successfully Created." }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1 or /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to book_url(@book), notice: "Book was Successfully Updated." }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1 or /books/1.json
  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was Successfully Deleted." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:id])
    end


    # Only allow a list of trusted parameters through.
    def book_params
      params.require(:book).permit(:title, :published_at, :language, :library_id, :author_id)
    end
end
