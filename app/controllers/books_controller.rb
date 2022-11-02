class BooksController < ApplicationController
  def index
    if filter_params[:value].present?
      @pagy, @books = pagy(filtered_books(filter_params).order(params[:sort_by]), page: params[:page])
    else
      @pagy, @books = pagy(Book.order(params[:sort_by]), page: params[:page])
    end
    render json: { books: @books, page_info: @pagy }
  end

  def filter_params
    params.require(:filter).permit(:column, :type, :value)
  end

  def filtered_books(params)
    column = params[:column]
    type = params[:type]
    value = params[:value]
    if %w[count range].include?(column)
      if type == 'more then'
        Book.where("#{column} > ?", value)
      elsif type == 'less then'
        Book.where("#{column} < ?", value)
      else
        Book.where("#{column} = ?", value)
      end
    elsif type == 'include'
      Book.where('title ILIKE ?', '%' + value + '%')
    else
      Book.where('title = ?', value)
    end
  end
end
