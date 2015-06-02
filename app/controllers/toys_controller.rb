class ToysController < ApplicationController

  def destroy
    @toy = Toy.find(params[:id])
    @toy.destroy
    redirect_to 'root'
  end


  def show
    @toy = Toy.find(params[:id])
    render 'show'
  end

  def update
    @toy = Toy.find(params[:id])
    if @toy.update(toy_params)
      render 'show'
    else
      render json: @toy.errors.full_messages, status: 422
    end
  end

  private
  def toy_params
    params.require(:toy).permit(:pokemon_id)
  end
end
