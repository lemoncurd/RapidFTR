class FormSectionController < ApplicationController
  def index
#    @thing = FormSection.new
#    @thing.add_field(Field.new("sme name", "_text_field"))

    #@form_sections = form_section_repository.get_all_form_sections

    @form_sections = [ FormSection.new("Basic Details"), FormSection.new("Family Details") ]

  end
end
