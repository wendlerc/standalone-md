#!/usr/bin/env ruby
require 'kramdown'
require 'fileutils'

# Check if a markdown file was provided
if ARGV.empty?
  puts "Usage: ruby converter_improved.rb <markdown_file>"
  exit 1
end

markdown_file = ARGV[0]
output_file = markdown_file.sub(/\.md$/, '.html')

# Read the Markdown file
markdown_content = File.read(markdown_file)

# Convert Markdown to HTML with GitHub-style fenced code blocks
html_content = Kramdown::Document.new(
  markdown_content,
  input: 'GFM',         # GitHub Flavored Markdown
  syntax_highlighter: 'rouge',
  hard_wrap: false      # Don't convert newlines to <br> tags
).to_html

# Create a complete HTML document with styling, syntax highlighting, and MathJax
full_html = <<~HTML
  <!DOCTYPE html>
  <html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>#{File.basename(markdown_file, ".md")}</title>
    <style>
      body {
        font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
        line-height: 1.6;
        color: #333;
        max-width: 800px;
        margin: 0 auto;
        padding: 2em;
      }
      pre {
        background: #f6f8fa;
        padding: 1em;
        border-radius: 5px;
        overflow-x: auto;
        margin: 1.5em 0;
      }
      code {
        font-family: SFMono-Regular, Consolas, Liberation Mono, Menlo, monospace;
        background: #f6f8fa;
        padding: 0.2em 0.4em;
        border-radius: 3px;
        font-size: 85%;
      }
      pre code {
        background: none;
        padding: 0;
        font-size: 92%;
      }
      h1, h2, h3, h4, h5, h6 {
        margin-top: 1.5em;
        margin-bottom: 0.5em;
        font-weight: 600;
        line-height: 1.25;
      }
      h1 { font-size: 2em; border-bottom: 1px solid #eaecef; padding-bottom: 0.3em; }
      h2 { font-size: 1.5em; border-bottom: 1px solid #eaecef; padding-bottom: 0.3em; }
      p { margin: 1em 0; }
      a {
        color: #0366d6;
        text-decoration: none;
      }
      a:hover {
        text-decoration: underline;
      }
      img {
        max-width: 100%;
        box-sizing: content-box;
      }
      table {
        border-collapse: collapse;
        width: 100%;
        margin: 1em 0;
      }
      table, th, td {
        border: 1px solid #dfe2e5;
      }
      th, td {
        padding: 6px 13px;
        text-align: left;
      }
      tr:nth-child(even) {
        background-color: #f6f8fa;
      }
      blockquote {
        margin: 0;
        padding: 0 1em;
        color: #6a737d;
        border-left: 0.25em solid #dfe2e5;
      }
      ul, ol {
        padding-left: 2em;
      }
      /* Syntax highlighting styles */
      .highlight .c, .highlight .cm, .highlight .c1, .highlight .cs { color: #6a737d; } /* Comment */
      .highlight .k, .highlight .kc, .highlight .kd, .highlight .kn, .highlight .kp, .highlight .kr, .highlight .kt { color: #d73a49; } /* Keyword */
      .highlight .s, .highlight .sb, .highlight .sc, .highlight .sd, .highlight .s2, .highlight .s1 { color: #032f62; } /* String */
      .highlight .na, .highlight .bp { color: #005cc5; } /* Name.Attribute, Name.Builtin.Pseudo */
      .highlight .nb, .highlight .nc, .highlight .nf { color: #6f42c1; } /* Name.Builtin, Name.Class, Name.Function */
      .highlight .no, .highlight .nd, .highlight .ni, .highlight .ne, .highlight .nv { color: #e36209; } /* Name.Constant, Name.Decorator, etc */
      .highlight .o, .highlight .ow { color: #d73a49; } /* Operator, Operator.Word */
      .highlight .m, .highlight .mf, .highlight .mh, .highlight .mi, .highlight .mo { color: #005cc5; } /* Literal.Number */
    </style>
    <!-- MathJax for rendering math equations -->
    <script type="text/javascript" id="MathJax-script" async
      src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js">
    </script>
  </head>
  <body>
    #{html_content}
  </body>
  </html>
HTML

# Write the HTML file
File.write(output_file, full_html)

puts "Converted #{markdown_file} to #{output_file}" 