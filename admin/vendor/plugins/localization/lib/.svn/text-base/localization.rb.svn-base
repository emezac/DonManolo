module Localization
  mattr_accessor :lang
  mattr_accessor :undefined_keys, :enable_detect_undefined_keys
  
  @@l10s = { :default => {} }
  @@lang = :default
  
  #PATCH
  @@undefined_keys=[]
  @@enable_detect_undefined_keys=false
  
		
  MODEL_DIR   = File.join(RAILS_ROOT, "app/models")  

  def self._(string_to_localize, *args)
    value=@@l10s[@@lang][string_to_localize]
    if value.nil? && @@enable_detect_undefined_keys && @@lang!=:default
      @@l10s[@@lang][string_to_localize]=string_to_localize
      undefined_keys << " l.store '#{string_to_localize.dump}', '#{string_to_localize.dump}'" 
    end
    
    translated = value || string_to_localize
    return translated.call(*args).to_s  if translated.is_a? Proc
    if translated.is_a? Array
      translated = if translated.size == 3 
        translated[args[0]==0 ? 0 : (args[0]>1 ? 2 : 1)]
      else
        translated[args[0]>1 ? 1 : 0]
      end
    end
    sprintf translated, *args
  end
  
  def self.define(lang = :default)
    @@l10s[lang] ||= {}
    yield @@l10s[lang]
  end
  
  def self.load
    Dir.glob("#{RAILS_ROOT}/lang/*.rb"){ |t| require t }
    Dir.glob("#{RAILS_ROOT}/lang/custom/*.rb"){ |t| require t }
  end
  
  # Generates a best-estimate l10n file from all views by
  # collecting calls to _() -- note: use the generated file only
  # as a start (this method is only guesstimating)
  def self.generate_l10n_file
    "Localization.define('en_US') do |l|\n" <<
    Dir.glob("#{RAILS_ROOT}/app/views/**/*.rhtml").collect do |f| 
      ["# #{f}"] << File.read(f).scan(/<%.*[^\w]_\s*[\"\'](.*?)[\"\']/)
    end.uniq.flatten.collect do |g|
      g.starts_with?('#') ? "\n  #{g}" : "  l.store '#{g}', '#{g}'"
    end.uniq.join("\n") << "\nend"
  end
  
  #PATCH
  # Updates a (best-estimate) l10n file from all *.rhtml (in app/views/) and
  # all *.rb (both in app/ and lib/ folder), collecting calls to _().
  # Previous keys unused are collected at the end.
  # Supports array values, but not lambda values.
  # -- note: this method is only guesstimating
  #
  # Sample usage:
  #   File.open('lang/italian.rb','w') do |file|
  #     file << Localization.update_l10n_file('it_IT')
  #   end
  #  
  def self.update_l10n_file(lang)
    prev_values=@@l10s[lang].dup
    ruby_souces=Dir.glob("#{RAILS_ROOT}/app/**/*.rb")+ 
     Dir.glob("#{RAILS_ROOT}/lib/**/*.rb")
    erb_sources=Dir.glob("#{RAILS_ROOT}/app/views/**/*.rhtml")
	
    keys=process_model_files
    keys+=erb_sources.collect{|f| ["# #{f}"] << File.read(f).scan(/<%.*[^\w]_\s*\(?[\"\'](.*?)[\"\']/) }
    keys+= ruby_souces.collect{|f|["# #{f}"] << File.read(f).scan(/.*[^\w]_\s*\(?[\"\'](.*?)[\"\']/) }
  
   "Localization.define('#{lang}') do |l|\n" <<
     keys.uniq.flatten.collect do |g|
       prev_values.delete(g)
       g.starts_with?('#') ? "\n  #{g}" : "  l.store '#{g}', #{format_value(@@l10s[lang][g] || g)}"
     end.uniq.join("\n") << 
     "\n\n# Unused keys\n" << 
       prev_values.collect do |key,value|
          " l.store '#{key}', '#{value}'"
      end.join("\n") << "\nend"
 end
 
 private

 def self.format_value(s)
   return s.inspect if s.is_a?(Array)
   return "\"#{s.to_s}\"" if s.is_a?(Proc)
   s.dump
 end
 
 def self.process_model_files
   keys=[]
   model_files.each do |m|
     class_name = m.sub(/\.rb$/,'').camelize
     klass = class_name.split('::').inject(Object){ |klass,part| klass.const_get(part) } rescue nil 
     if klass && klass < ActiveRecord::Base && ! klass.abstract_class?
       col_keys=[[Inflector.humanize(klass), Inflector.pluralize(klass)]]
       klass.content_columns.each{|col| col_keys << ["#{Inflector.humanize(col.name)}"]}
       s=["# Model #{klass.table_name}"]
       keys << [s, col_keys]
     end
   end
   keys
 end
 
 def self.model_files
   Dir.chdir(MODEL_DIR) do 
     models = Dir["**/*.rb"]
   end
 end  
    
end

class Object
  def _(*args); Localization._(*args); end
end