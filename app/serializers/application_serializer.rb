class ApplicationSerializer
  def self.preloads
    []
  end

  def self.render(item, **assigns)
    if assigns.any?
      new.render(item, **assigns)
    else
      new.render(item)
    end
  end

  def self.render_many(items, **assigns)
    items.map { |i| render(i, **assigns) }
  end

  def self.render_paginated(paginated_items, as:, assigns: {})
    {
      as => render_many(paginated_items, **assigns),
      pagination: PaginationSerializer.render(paginated_items)
    }
  end
end
