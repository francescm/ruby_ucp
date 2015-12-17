#encoding: utf-8

require_relative '../../lib/ucp/base'
require_relative '../../lib/ucp/util/base'
require_relative '../../lib/ucp/util/ucp_client'
#require_relative '../../lib/ucp/pdu/ucp60'
#require_relative '../../lib/ucp/pdu/ucp60_operation'


module Ucp::Util
  describe UcpClient do
    before(:all) do
      @host = "99.99.99.99"
      @port = "5000"
    end

    it "connects" do
      expect(TCPSocket).to receive(:new).with(@host, @port)
      client = UcpClient.new(@host, @port)
      client.connect
    end

    
  end
end