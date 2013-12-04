class String
  # Stolen unashamadly from ActiveSupport http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-underscore
  def underscore
    self.gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end
end