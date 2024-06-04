class Api::V1::WatchesFilter
  DEFAULT_ORDER_BY = "ASC"
  ALLOWED_SORT_BY = %w[price category name]

  def initialize(params, watches)
    @params = params
    @watches = watches
  end

  def filter
    filter_by_price
    apply_search_query
    apply_sorting
    @watches
  end

  private

  def filter_by_price
    case @params[:price]
    when Hash
      if @params[:price]
        @watches = @watches.where('price > ?', @params[:price][:gt]) if @params[:price][:gt].present?
        @watches = @watches.where('price >= ?', @params[:price][:gte]) if @params[:price][:gte].present?
        @watches = @watches.where('price < ?', @params[:price][:lt]) if @params[:price][:lt].present?
        @watches = @watches.where('price <= ?', @params[:price][:lte]) if @params[:price][:lte].present?
      end
    when Array
      @watches = @watches.where(price: @params[:price])
    end
  end

  private

  def apply_search_query
    @watches = @watches.where("name ILIKE ?", "%#{@params[:q]}%") if @params[:q].present?
  end

  private

  def apply_sorting
    order_by = @params[:order_by] ? @params[:order_by] : "ASC"
    if @params[:sort_by] == 'category'
      @watches = @watches.joins("INNER JOIN categories ON watches.category_id = categories.id").order("categories.name #{order_by}")
    elsif ALLOWED_SORT_BY.include?(@params[:sort_by])
      @watches = @watches.order("#{@params[:sort_by]} #{order_by}")
    end
  end
end
