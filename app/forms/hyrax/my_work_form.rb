# Generated via
#  `rails generate hyrax:work MyWork`
module Hyrax
  # Generated form for MyWork
  class MyWorkForm < Hyrax::Forms::WorkForm
    self.model_class = ::MyWork
    self.terms += [:resource_type]
  end
end
