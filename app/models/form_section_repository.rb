class FormSectionRepository
  def self.all
     FormSectionDefinition.all().select {|item| FormSection.new()}
  end
end