module API
end

API::Root.class_eval do
  mount API::V1::Root
end
