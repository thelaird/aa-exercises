class SubsController < ApplicationController
  before_action :require_moderator, only: [:edit, :update]

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by(params[:id])
    render :edit
  end

  def new
    @sub = Sub.new
    render :new
  end

  def update
    @sub = Sub.find_by(params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def show
    @sub = Sub.find(params[:id])
    render :show
  end

  private

  def require_moderator
    @sub = Sub.find_by(params[:id])
    unless current_user.id == @sub.moderator_id
      flash[:errors] ||= []
      flash[:errors] << "Not moderator"
      redirect_to sub_url(@sub)
    end
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
