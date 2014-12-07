require 'logger'
require 'eavesdropper/listener'
require 'eavesdropper/eavesdroppable'
require 'eavesdropper/method'

module Eavesdropper
  def self.logger=(logger)
    raise StandardError.new("Logger must respond to '#add'") unless logger.respond_to? :add
    @logger = logger
  end
  
  def self.logger
    @logger ||= Logger.new(STDOUT)
  end

  def self.log_level=(level)
    @log_level = level
  end

  def self.log_level
    @log_level ||= 0
  end
end
