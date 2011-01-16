=begin
Ruby library implementation of EMI/UCP protocol v4.6 for SMS
Copyright (C) 2011, Sergio Freire <sergio.freire@gmail.com>

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301  USA
=end

class Ucp::Pdu::Ucp01Result < Ucp::Pdu::UCP01

  def initialize(fields=nil)
    super()
    @operation_type="R"
    if fields.nil?
      return
    end

    @trn=fields[0]
    if fields[4].eql?("A")
      # 06/00043/R/01/A/01234567890:090196103258/4E
      ack(fields[5])
    elsif fields[4].eql?("N")
      # 12/00022/R/01/N/02//03
      nack(fields[5],fields[6])
    else
      raise "invalid result in UCP01"
    end

    # TODO: verificar len e checksum

  end


  def ack(sm="")
    @fields=[:ack,:sm]
    @h[:ack]="A"
    @h[:sm]=sm
  end

  def nack(ec,sm="")
    @fields=[:nack,:ec,:sm]
    @h[:nack]="N"
    @h[:ec]=ec
    @h[:sm]=sm
  end



end
