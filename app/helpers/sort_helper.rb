# frozen_string_literal: true

module SortHelper
  def sortable(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    link_to(customers_path(sort: column, direction:), data: { turbo_stream: true }) do
      safe_join([title, sort_indicator(column)])
    end
  end

  private

  def sort_indicator(column)
    if column == sort_column
      direction = sort_direction == 'asc' ? '↑' : '↓'
      tag.small(direction, class: 'small pl-1 align-text-bottom text-gray-500')
    else
      tag.small('↕', class: 'small pl-1 align-text-bottom text-gray-500')
    end
  end

  def sort_column
    params[:sort] || 'first_name'
  end

  def sort_direction
    params[:direction] || 'asc'
  end
end
