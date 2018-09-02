# Fix excess spaces while rendering multiline string
# Should be fixed in HAML 5
# https://github.com/haml/haml/issues/869
require 'haml/template'

Haml::Template.options[:ugly] = true

