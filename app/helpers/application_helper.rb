module ApplicationHelper
  # retorna el titulo completo sobre una pagina
  def full_title(page_title)
    base_title = "Bloombee"
    if page_title.empty?
      base_title
    else
      "#{base_title}: #{page_title}"
    end
  end
  
  # link para ordenar consultas
  def sortable(column, title = nil)
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    link_to title, {:sort => column, :direction => direction}, {:class => css_class}
  end
    
end
