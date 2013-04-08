module ApplicationHelper

  class HTMLwithPygments < Redcarpet::Render::HTML
    include Redcarpet::Render::SmartyPants

    def block_code(code, language)
      Pygments.highlight(code, :lexer => language)
    end
  end

  def markdown(text)
    renderer = HTMLwithPygments.new(:hard_wrap => true)
    options = {
      :fenced_code_blocks => true,
      :no_intra_emphasis => true,
      :tables => true,
      :autolink => true,
      :strikethrough => true,
      :lax_html_blocks => true,
      :superscript => true
    }
    Redcarpet::Markdown.new(renderer, options).render(text)
  end

  def menu
    [
      {:label => 'Blog',    :path => articles_path,       :access => :public},
      {:label => 'PGP Key', :path => viewer_pgp_key_path, :access => :public, :action => 'pgp_key'},
      {:label => 'About',   :path => viewer_about_path,   :access => :public, :action => 'about'},
      {:label => 'Videos',  :path => viewer_videos_path,  :access => :connected, :action => 'videos'},
#      {:label => 'Sandbox', :path => viewer_sandbox_path, :access => :admin, :action => 'sandbox'},
    ]
  end

  def duration(seconds)
    hours = seconds / 60
    "#{hours}:#{seconds - hours * 60}"
  end
end
