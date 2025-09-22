# config/initializers/active_model_serializers.rb
# Use the attributes adapter to produce simple JSON objects instead of JSON-API
if defined?(ActiveModelSerializers)
  ActiveModelSerializers.config.adapter = :attributes
end
