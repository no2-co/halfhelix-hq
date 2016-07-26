class Project < ApplicationRecord

  # Status Constants
  STATUS_DRAFT = 'draft'
  STATUS_SENT  = 'sent'
  STATUS_PAID  = 'paid'
  STATUS_CLOSED  = 'closed'

  # Validations
  # TODO: add - :client_id,
  validates :code, :presence => true
  validates :status, :inclusion => { :in => [STATUS_PAID, STATUS_SENT, STATUS_DRAFT, STATUS_CLOSED], :message => "You need to pick one status." }
  validates :discount, :numericality => { :greater_than_or_equal_to => 0, :less_than_or_equal_to => 100 }

  # def total
  #   items_total * (1 - self.discount / 100) * (1 + self.tax / 100)
  # end
  #
  # def subtotal
  #   items_total * (1 - self.discount / 100)
  # end

  def status_tag
    case self.status
      when STATUS_DRAFT then :error
      when STATUS_SENT then :warning
      when STATUS_PAID then :ok
    end
  end

  class << self
    def suggest_code
      invoice = order('created_at desc').limit(1).first
      if invoice
        "INV-#{invoice.id + 1}"
      else
        "INV-1"
      end
    end

    def status_collection
      {
        "Draft" => STATUS_DRAFT,
        "Sent" => STATUS_SENT,
        "Paid" => STATUS_PAID,
        "Closed" => STATUS_CLOSED
      }
    end

    def this_month
      where('created_at >= ?', Date.new(Time.now.year, Time.now.month, 1).to_datetime)
    end
  end

  #TODO: Complex info for Items
  # def items_total
  #   items_total = 0
  #   self.items.each do |i|
  #     items_total += i.total
  #   end
  #   items_total
  # end


end
