class RegistrationSerializer
  include FastJsonapi::ObjectSerializer
  attributes :protected_email, :protected_name

  attribute :protected_email do |obj|
    obj.email.sub(/\A(..).*@.*(..)\z/, '\1****@****\2')
  end

  attribute :protected_name do |obj|
    obj.name.sub(/\A(..).*\s+.*(..)\z/, '\1**** ****\2')
  end
end
