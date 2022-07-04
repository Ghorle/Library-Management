class LibrariesController < ApplicationController
  before_action :set_library, only: %i[ show edit update destroy ]
  before_action :set_book, only: %i[ show ]
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:edit, :update, :destroy, :show]
  before_action :admin_create, only: [:create]

  # GET /libraries or /libraries.json
  def index
    @libraries = Library.all
    @books = Book.all
  end

  # GET /libraries/1 or /libraries/1.json
  def show
    @users = User.all
    @libraries = Library.all
    @books = Book.where(library_id: @library.id)
  end

  # GET /libraries/new
  def new
    @library = Library.new
  end

  # GET /libraries/1/edit
  def edit
  end

  # POST /libraries or /libraries.json
  def create
    @library = Library.new(library_params)

    respond_to do |format|
      if @library.save
        format.html { redirect_to library_url(@library), notice: "Library was successfully created." }
        format.json { render :show, status: :created, location: @library }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /libraries/1 or /libraries/1.json
  def update
    respond_to do |format|
      if @library.update(library_params)
        format.html { redirect_to library_url(@library), notice: "Library was successfully updated." }
        format.json { render :show, status: :ok, location: @library }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @library.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /libraries/1 or /libraries/1.json
  def destroy
    @library.destroy

    respond_to do |format|
      format.html { redirect_to libraries_url, notice: "Library was successfully deleted." }
      format.json { head :no_content }
    end
  end

  def correct_user
    if user_signed_in?
      @library = current_user.libraries.find_by(id: params[:id])
      redirect_to libraries_path, notice: "Not Athorized." if @library.nil?
    end
  end

  def admin_create
    if !current_user.admin?
      @library = nil
    else
      @library = true
    end
    redirect_to libraries_path, notice: "You are not Admin. Please try with Admin account." if @library.nil?
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_library
      @library = Library.find(params[:id])
    end

    def set_book
      @book = Book.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def library_params
      params.require(:library).permit(:name, :opening_time, :closing_time, :user_id)
    end
end
   