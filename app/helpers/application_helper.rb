module ApplicationHelper
  def markdown(text)
    rndr = Redcarpet::Render::HTML.new(:hard_wrap => true)
    md = Redcarpet::Markdown.new(rndr)
    md.render text
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
