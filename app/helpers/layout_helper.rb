module LayoutHelper

  def motto(smart_punctuation=true)
    "A geek stranded on Martha#{smart_punctuation ? '&rsquo;' : "'"}s Vineyard".html_safe
  end

  def set_title(page_title, show_title=true)
    content_for(:title) { page_title.to_s }
    @show_title = show_title
  end

  def show_title?
    @show_title
  end

end
