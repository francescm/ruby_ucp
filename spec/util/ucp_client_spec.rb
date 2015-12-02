#encoding: utf-8

require_relative '../../lib/ucp/base'
require_relative '../../lib/ucp/util/base'
require_relative '../../lib/ucp/util/ucp_client'


module Ucp::Util
  describe UcpClient do
    it "connects" do
      host = "99.99.99.99"
      port = "5000"
      socket = class_double("TCPSocket")
      expect(TCPSocket).to receive(:new).with(host, port)
      client = UcpClient.new(host, port)
    end
  end
end