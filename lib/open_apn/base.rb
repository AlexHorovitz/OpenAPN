module OpenAPN
  require 'socket'
  require 'openssl'
  require 'json'

  @host = 'gateway.sandbox.push.apple.com'
  @port = 2195

  @pem = nil # use path to the pem file here...
  @pass = nil

  class << self
    attr_accessor :host, :pem, :port, :pass
  end

  def self.send_notification(device_token, message)
    n = OpenAPN::Notify.new(device_token, message)
    self.send_notifications([n])
  end

  def self.send_notifications(notifications)
    sock, ssl = self.open_connection

    notifications.each do |n|
      ssl.write(n.notification_payload)
    end

    ssl.close
    sock.close
  end

  def self.feedback
    sock, ssl = self.feedback_connection

    apn_feedback = []

    while message = ssl.read(38)
      timestamp, token_size, token = message.unpack('N1n1H*')
      apn_feedback << [Time.at(timestamp), token]
    end

    ssl.close
    sock.close

    return apn_feedback
  end

  protected

  def self.open_connection
    raise "Path to the pem file is not set correctly. (OpenAPN.pem = /path/to/cert.pem)" unless self.pem
    raise "Path to the pem file does not exist!" unless File.exist?(self.pem)

    context      = OpenSSL::SSL::SSLContext.new
    context.cert = OpenSSL::X509::Certificate.new(File.read(self.pem))
    context.key  = OpenSSL::PKey::RSA.new(File.read(self.pem), self.pass)

    sock         = TCPSocket.new(self.host, self.port)
    ssl          = OpenSSL::SSL::SSLSocket.new(sock,context)
    ssl.connect

    return sock, ssl
  end

  def self.feedback_connection
    raise "Path to the pem file is not set. (OpenAPN.pem = /path/to/cert.pem)" unless self.pem
    raise "Path to the pem file does not exist!" unless File.exist?(self.pem)

    context      = OpenSSL::SSL::SSLContext.new
    context.cert = OpenSSL::X509::Certificate.new(File.read(self.pem))
    context.key  = OpenSSL::PKey::RSA.new(File.read(self.pem), self.pass)

    fhost = self.host.gsub('gateway','feedback')
    puts fhost

    sock         = TCPSocket.new(fhost, 2196)
    ssl          = OpenSSL::SSL::SSLSocket.new(sock,context)
    ssl.connect

    return sock, ssl
  end
end
