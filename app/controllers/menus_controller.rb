class MenusController < ApplicationController

  def index
    @menus = Menu.all
  end

  def show
    @menu = Menu.find(params[:id])
    @solution = @menu.solve_for_total
  end

  def new
    @menu = Menu.new
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def create
    # Deal with Heroku's read-only file system by grabbing temp file in production
    if Rails.env.development?
      @file = params[:menu][:file].read
    else
      @file = IO.read(params[:menu][:file].path)
    end

    @params = Menu.parse_file(@file)
    @menu = Menu.new(@params)

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, notice: 'We have processed your menu problem!' }
        format.json { render json: @menu, status: :created, location: @menu }
      else
        format.html { render action: "new" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @menu = Menu.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to @menu, notice: 'Menu was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @menu.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
    end
  end
end
