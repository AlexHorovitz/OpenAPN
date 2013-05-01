module OpenAPN
  class Notify
    attr_accessor :device_token, :alert, :badge, :sound, :other
    
    def initialize(device_token, message)
      self.device_token = device_token
      if message.is_a?(Hash)
        self.alert = message[:alert]
        self.badge = message[:badge]
        self.sound = message[:sound]
        self.other = message[:other]
      elsif message.is_a?(String)
        self.alert = message
      else
        raise "A notification must be a hash or string"
      end
    end
        
    def notification_payload
      pt = self.payload_token
      pm = self.payload_message
      [0, 0, 32, pt, 0, pm.bytesize, pm].pack("ccca*cca*")
    end
  
    def payload_token
      [device_token.gsub(/[\s|<|>]/,'')].pack('H*')
    end
  
    def payload_message
      aps = {'aps'=> {} }
      aps['aps']['alert'] = self.alert if self.alert
      aps['aps']['badge'] = self.badge if self.badge
      aps['aps']['sound'] = self.sound if self.sound
      aps.merge!(self.other) if self.other
      aps.to_json
    end
    
  end
end
