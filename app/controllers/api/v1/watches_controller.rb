class Api::V1::WatchesController < ApplicationController
  def index
    watches = get_filtered_watches

    render json: watches, each_serializer: Api::V1::WatchesSerializer
  end

  def create
    watch = Watch.new(watch_params)

    if watch.save
      render json: watch, serializer: Api::V1::WatchesSerializer, status: :created
    else
      render json: watch.errors, status: :unprocessable_entity
    end
  end

  def update
    watch = Watch.find(params[:id])

    if watch.update(watch_params)
      render json: watch, serializer: Api::V1::WatchesSerializer
    else
      render json: watch.errors, status: :unprocessable_entity
    end
  end

  def destroy
    Watch.find(params[:id]).destroy!

    head :no_content
  end

  private

  def watch_params
    params.require(:watch).permit(:name, :description, :price, :image, :category_id)
  end

  private

  def get_filtered_watches
    if params[:category].present?
      category = Category.find(params[:category])
      watches = category ? category.watches : Watch.none
    else
      watches = Watch.all
    end

    Api::V1::WatchesFilter.new(params, watches).filter
  end
end
