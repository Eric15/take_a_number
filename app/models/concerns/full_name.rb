module FullName
  extend ActiveSupport::Concern

  def full_name
    [ first_name, last_name ].compact.join(" ")
  end

end
