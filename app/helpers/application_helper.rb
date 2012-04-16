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
end
