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
    @menu = Menu.new(params[:menu])

    respond_to do |format|
      if @menu.save
        format.html { redirect_to @menu, {"notice" => "We have processed your menu problem!"}}
      else
        format.html { render action: "new"}
      end
    end
  end

  def update
    @menu = Menu.find(params[:id])

    respond_to do |format|
      if @menu.update_attributes(params[:menu])
        format.html { redirect_to @menu, {"notice" => "Menu was successfully updated."}}
      else
        format.html { render action: "new"}
      end
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
    end
  end
end
