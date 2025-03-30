# Markdown to HTML Converter

A simple tool to convert Markdown files to standalone HTML pages with styling and MathJax support.

## Setup (One-Time Steps)

1. **Install Ruby** (if you haven't already)
   - On macOS with Homebrew: `brew install ruby@3.2`
   - Add to PATH: `export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH"`

2. **Install the Kramdown gem**
   ```bash
   gem install kramdown
   ```

3. **Save the converter script**
   - The script is available at: `converter.rb` in this directory
   - You can copy it anywhere you need it

## Converting a Markdown File to HTML

### Step 1: Create your Markdown file
Create a Markdown file (`.md`) with your content. You can include:
- Headers (using `#`, `##`, etc.)
- Lists (using `-` or `*` for bullets)
- Code blocks (using triple backticks)
- Math equations (using `$` for inline and `$$` for block equations)
- Images and links
- Tables

### Step 2: Run the converter
Open Terminal and run:

```bash
cd /path/to/your/markdown/files
export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH"
ruby /path/to/converter.rb your-file.md
```

Replace `your-file.md` with the name of your Markdown file.

### Step 3: Find your HTML file
The HTML file will be created in the same directory as your Markdown file, with the same name but with an `.html` extension.

### Step 4: Upload to GitHub Pages or other hosting
Upload the generated HTML file to your GitHub Pages repository or any web hosting service.

## Example

Let's say you have a file called `research-paper.md` in your Documents folder:

```bash
cd ~/Documents
export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH"
ruby /Users/chriswendler/Documents/2025/code/standalone-md/converter.rb research-paper.md
```

This will create `research-paper.html` in your Documents folder.

## Tips for Writing Your Markdown Files

### Basic Markdown Syntax

```markdown
# Main Title

## Subtitle

This is a paragraph with **bold** and *italic* text.

- Bullet point 1
- Bullet point 2
  - Nested bullet point

1. Numbered item 1
2. Numbered item 2

[Link text](https://example.com)

![Image description](path/to/image.jpg)

> This is a quote

| Column 1 | Column 2 |
|----------|----------|
| Cell 1   | Cell 2   |
```

### Code Blocks

````markdown
```python
def example_function():
    return "This is syntax highlighted code"
```
````

### Math Equations

```markdown
Inline equation: $E = mc^2$

Block equation:
$$\frac{d}{dx}(e^x) = e^x$$
```

## Customizing the HTML Output

If you want to customize the appearance of your HTML files:

1. Open `converter.rb` in a text editor
2. Modify the CSS styles in the `style` section
3. Save the file
4. Run the converter again

## Making the Converter Easier to Use

If you find yourself using this often, you can create a shortcut:

1. Add this line to your `~/.zshrc` file:
   ```bash
   alias md2html='export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH" && ruby /path/to/converter.rb'
   ```

2. Reload your terminal configuration:
   ```bash
   source ~/.zshrc
   ```

3. Now you can simply use:
   ```bash
   md2html your-file.md
   ```

## Troubleshooting

If you encounter any issues:

- **Ruby not found**: Make sure to run `export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH"` first
- **Kramdown not found**: Run `gem install kramdown`
- **File not found**: Check that you're in the correct directory or using the full path
- **Math rendering issues**: Make sure your page has internet access to load MathJax

## Features of the Generated HTML

- Clean, responsive design
- Syntax highlighting for code blocks
- Math equation rendering via MathJax
- Mobile-friendly layout
- Automatic table of contents
- Optimized typography

## Using the Improved Converter

I've included an improved version of the converter script (`converter_improved.rb`) that offers:

1. Better handling of code blocks with syntax highlighting
2. GitHub-flavored Markdown support
3. Improved styling that closely resembles GitHub's style
4. Better rendering of tables, lists, and blockquotes

To use the improved converter:

```bash
cd /path/to/your/markdown/files
export PATH="/opt/homebrew/opt/ruby@3.2/bin:$PATH"
ruby /path/to/converter_improved.rb your-file.md
```

You may need to install the 'rouge' gem for syntax highlighting:

```bash
gem install rouge
```

I recommend using this improved version for better results with complex Markdown documents.

## Using the Shell Script (Easiest Method)

For the easiest experience, I've created a shell script that handles all the Ruby environment setup for you:

1. Make sure the script is executable (this should already be done):
   ```bash
   chmod +x /path/to/md2html
   ```

2. Run the script with your Markdown file:
   ```bash
   /path/to/md2html your-file.md
   ```

3. If you want to use it from anywhere, you can:
   - Copy it to a directory in your PATH: `cp md2html /usr/local/bin/`
   - Or create a symbolic link: `ln -s /full/path/to/md2html /usr/local/bin/md2html`

This is the simplest way to convert your Markdown files to HTML!

## Conclusion

With this tool, you can:
1. Write content in Markdown
2. Convert to beautiful HTML with a single command
3. Upload to GitHub Pages or any web host
4. Share your content with the world

No need to run a Jekyll server or manage complex static site generators for simple content publishing. 