module Friendly
  module FinderMethods
    def find(*args)
      find(*args)
    rescue ActiveRecord::RecordNotFound
      die
    end
  end
end