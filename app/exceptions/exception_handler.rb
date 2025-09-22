# app/exceptions/exception_handler.rb
module ExceptionHandler
  # Raised when JWT token decoding fails in an expected way.
  # Subclassing JWT::DecodeError allows existing rescues for JWT::DecodeError
  # to catch this specific exception as well.
  class InvalidToken < JWT::DecodeError; end
end
