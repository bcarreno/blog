module ApplicationHelper

  class MarkdownRenderer < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      time_start = Time.now
      highlighted_code = CodeRay.highlight(code, language)
      Rails.logger.debug "block_code took #{'%.3f' % ((Time.now-time_start)*1000)} ms on #{code.size} chars"
      highlighted_code
    end
  end

  def markdown(text)
    renderer = MarkdownRenderer.new(:hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :tables => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :footnotes => true,
      :superscript => true,
    }
    markdown_to_html = Redcarpet::Markdown.new(renderer, options)
    markdown_to_html.render(text).html_safe
  end

  def menu
    [
      {:label => 'Blog',    :path => articles_path,       :access => :public},
      {:label => 'PGP Key', :path => viewer_pgp_key_path, :access => :public, :action => 'pgp_key'},
      {:label => 'About',   :path => viewer_about_path,   :access => :public, :action => 'about'},
      {:label => 'Videos',  :path => viewer_videos_path,  :access => :connected, :action => 'videos'},
    ]
  end

  def duration(seconds)
    hours = seconds / 60
    "#{hours}:#{seconds - hours * 60}"
  end
end
