module Base
  class BaseService
    def self.call(*args)
      service = new(*args)
      service.call
      service
    end

    attr_reader :errors

    def initialize(*_args)
      @errors = []
    end

    def success?
      @errors.empty?
    end

    def error?
      !@errors.empty?
    end

    def first_error
      @errors.first
    end

    def add_error(error)
      if error.is_a?(BaseError)
        @errors << error
      elsif error.is_a?(Array)
        error.each { |e| add_error(e) }
      else
        @errors << BaseError.new(error)
      end
    end
  end
end
