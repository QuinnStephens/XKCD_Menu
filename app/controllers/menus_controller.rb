class MenusController < ApplicationController
  # GET /menus
  # GET /menus.json
  def index
    @menus = Menu.all
  end

  # GET /menus/1
  # GET /menus/1.json
  def show
    @menu = Menu.find(params[:id])
    @solution = @menu.solve_for_total
  end

  # GET /menus/new
  # GET /menus/new.json
  def new
    @menu = Menu.new
  end

  # GET /menus/1/edit
  def edit
    @menu = Menu.find(params[:id])
  end

  # POST /menus
  # POST /menus.json
  def create
    #@menu = Menu.new(params[:menu])
    # Deal with Heroku's read-only file system by grabbing temp file in production
    if Rails.env.development?
      @file = params[:menu][:file]
    else
      @file = IO.read(params[:menu][:file].path)
      puts "*****************"
      puts @file.inspect
      puts "*****************"
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

  # PUT /menus/1
  # PUT /menus/1.json
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

  # DELETE /menus/1
  # DELETE /menus/1.json
  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
      format.json { head :no_content }
    end
  end
end
