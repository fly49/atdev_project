class UpdateCurrencyJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    # Perform Job
  end
end