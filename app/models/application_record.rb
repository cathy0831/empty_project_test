class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
  extend Enumerize

  def formatted_errors
    errors.full_messages.join(", ")
  end
end
