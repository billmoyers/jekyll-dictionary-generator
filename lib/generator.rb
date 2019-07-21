# encoding: utf-8

require 'stringex'

module Jekyll

  class DictionaryEntry < Page

    def initialize(site, base, entry, target_language, ui_language)
      @site = site
      @base = base
      @dir  = @site.config['dictionary']['prefix']+'/'+ui_language+'/entries'
      @name = Utils.slugify(entry[target_language]+' '+entry['pos'])+'.html'
      self.process(@name)
      # Read the YAML data from the layout page.
	  self.read_yaml(__dir__, "dictionary_entry.html")
      self.data['title']       = entry[target_language]
	  self.data['description'] = self.data['title']
	  self.data['entry']       = entry
	  self.data['ui_language'] = ui_language
    end

    def read_yaml(base, name, opts = {})
      begin
        self.content = File.read(File.join(base, name))
        if content =~ /\A(---\s*\n.*?\n?)^((---|\.\.\.)\s*$\n?)/m
          self.content = $POSTMATCH
          self.data = SafeYAML.load($1)
        end
      rescue SyntaxError => e
        Jekyll.logger.warn "YAML Exception reading #{File.join(base, name)}: #{e.message}"
      rescue Exception => e
        Jekyll.logger.warn "Error reading file #{File.join(base, name)}: #{e.message}"
      end

      self.data ||= {}
    end
  end

  # The Site class is a built-in Jekyll class with access to global site config information.
  class Site

    def write_dictionary_entry(entry, target_language)
	  self.config['dictionary']['languages'].each do |ui_language|
		page = DictionaryEntry.new(self, self.source, entry, target_language, ui_language)
		page.render(self.layouts, site_payload)
		page.write(self.dest)
		self.pages << page 
	  end
    end

    def write_dictionary_entries
	  self.data['dictionary'].each do |de|
        self.write_dictionary_entry(de, self.config['dictionary']['target_language'])
	  end
    end

  end


  # Jekyll hook - the generate method is called by jekyll, and generates all of the category pages.
  class GenerateEntries < Generator
    safe true
    priority :normal

    def generate(site)
      site.write_dictionary_entries
    end

  end

end
