class PaginationSerializer
  def self.render(paginated_items)
    result = extract_keys(paginated_items, :current_page, :next_page, :prev_page, :total_pages, :total_count)
    result[:limit] = paginated_items.limit_value

    result
  end

  def self.extract_keys(paginated_items, *keys)
    keys.index_with do |key|
      paginated_items.send(key)
    end
  end
end
