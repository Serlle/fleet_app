# frozen_string_literal: true

# Money gem configuration to avoid deprecation warnings seen at runtime.
# The money gem will change its default currency to `nil` in a future
# release. Set a sensible app default here so seeds, fixtures and tests
# continue to behave and the warning goes away.

# Set default currency (ISO code). Adjust if your app uses another default.
if defined?(Money)
  begin
    Money.default_currency = "USD"
  rescue StandardError
    # Older/newer versions may expect a Money::Currency object; try that.
    Money.default_currency = Money::Currency.new("USD") if defined?(Money::Currency)
  end

  # Use I18n backend for localization if available to keep formatting stable.
  if Money.respond_to?(:locale_backend=)
    Money.locale_backend = :i18n
  end
end
