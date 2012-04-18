module ApplicationHelper
  class HTMLwithAlbino < Redcarpet::Render::HTML
    def block_code(code, language)
      Pygments.highlight(code, :lexer => language)
    end
  end

  def markdown(text)
    rndrAlbino = HTMLwithAlbino.new
    rndr = Redcarpet::Render::HTML.new(:hard_wrap => true)
    options = {:fenced_code_blocks => true,
               :tables => true,
               :autolink => true,
               :strikethrough => true,
               :lax_html_blocks => true,
               :superscript => true}
    md = Redcarpet::Markdown.new(rndrAlbino, options)
    xx = md.render(text)
		#syntax_highlighter(xx)
  end

=begin
<pre lang="ruby"><code>puts .....</code></pre>
<pre><code class="ruby">puts ....</code></pre>
=end

 	def syntax_highlighter(html)
 		#     Nokogiri::HTML(html) will add <html> and <body> tags.
 		doc = Nokogiri::HTML::DocumentFragment.parse(html)
 		doc.css("pre[code]").each do |pre|
 			pre.replace Albino.colorize(pre.text.rstrip, pre[:code])
 		end
 		doc.to_s
 	end

#  def markdown(text)
#    # http://rdoc.info/github/tanoku/redcarpet/master/Redcarpet
#  	options = [:hard_wrap,
#							 :filter_html,
#							 :autolink,
#							 :no_intraemphasis,
#							 :fenced_code,
#							 :gh_blockcode]
#		syntax_highlighter(Redcarpet.new(text, *options).to_html).html_safe
#	end
#
#	# This code is based on https://github.com/injekt/rack-pygmentize
#	# although this gem is not installed.
#	def syntax_highlighter(html)
#		#     Nokogiri::HTML(html) will add <html> and <body> tags.
#		doc = Nokogiri::HTML::DocumentFragment.parse(html)
#		doc.css("pre[lang]").each do |pre|
#			pre.replace Albino.colorize(pre.text.rstrip, pre[:lang])
#		end
#		doc.to_s
#	end
#
#  def markdown(text)
#    rndr_flags = { 
#      hard_wrap:       true,
#      gh_blockcode:    true,
#      safe_links_only: true
#    }
#    rndr = HTMLwithAlbino.new(rndr_flags)
#    redcarpet = Redcarpet::Markdown.new(rndr, :space_after_headers => true,
#      :fenced_code_blocks => true, :autolink => true, :no_intra_emphasis => true,
#      :strikethrough => true, :superscripts => true)
#    redcarpet.render(text).html_safe
#  end
#
#end
#
#class HTMLwithAlbino < Redcarpet::Render::HTML
#  def block_code(code, language)
#    Albino.safe_colorize(code, language)
#  end
end
