class MenusController < ApplicationController

  def index
    redirect_to [:new, :menu]
  end

  def show
    @menu = Menu.find(params[:id])
    @solution = @menu.solve_for_total
  end

  def new
    @menu = Menu.new
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

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    respond_to do |format|
      format.html { redirect_to menus_url }
    end
  end
end
