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

    it "should accept a range as local port" do
      source_host = "127.0.0.1"
      range_port = Range.new(60000, 61000)
      expect(TCPSocket).to receive(:new)
      client = UcpClient.new(@host, @port, nil, source_host, range_port)
      client.connect
      local_port = client.instance_variable_get("@local_port")
      expect(local_port).not_to be nil
      expect(range_port.cover? local_port).to be true
    end


    it "should reconnect inc local port" do
      source_host = "127.0.0.1"
      range_port = Range.new(60000, 61000)
      local_port = 60500
      expect(TCPSocket).to receive(:new)
      client = UcpClient.new(@host, @port, nil, source_host, range_port)
      client.instance_variable_set("@local_port", local_port)
      client.connect
      client_local_port = client.instance_variable_get("@local_port")
      expect(client_local_port).to eq (local_port + 1)
    end

    it "should wrap range" do
      source_host = "127.0.0.1"
      range_port = Range.new(60000, 61000)
      local_port = 61000
      expect(TCPSocket).to receive(:new)
      client = UcpClient.new(@host, @port, nil, source_host, range_port)
      client.instance_variable_set("@local_port", local_port)
      client.connect
      client_local_port = client.instance_variable_get("@local_port")
      expect(client_local_port).to eq (range_port.first)
    end
  end
end