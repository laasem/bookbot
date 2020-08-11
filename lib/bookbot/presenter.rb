# presenter.rb
#
module BookBot
  module Presenter

    def self.adapter_registry
      @adapter_registry ||= Hash.new
    end
    
    def self.adapter_for(adapter_name)
      adapter_registry.fetch(adapter_name) {
        require_relative  = "presenter/section/#{adapter_name}_adapter"
        adapter_klass     = Presenter.const_get(adapter_name.capitalize)    
        adapter           = adapter_klass.new
        adapter_registry[adapter_name] = adapter
        adapter
      }
    end


  end
end

