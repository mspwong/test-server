class PrintWorker
  include Sidekiq::Worker

  def perform(message)
    20.times { puts '*'*30; puts "#{message}" }
  end
end