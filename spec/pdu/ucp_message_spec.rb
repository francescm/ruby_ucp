#encoding: utf-8

require_relative '../../lib/ucp/base'
require_relative '../../lib/ucp/pdu/base'
require_relative '../../lib/ucp/pdu/ucpmessage'

module Ucp::Pdu

 describe UCPMessage do
    it "initializes with no args" do
      u = UCPMessage.new
      expect u
    end
  end

end
