class UnscheduledEvent < Event

  # INCLUSIONS

  include RankedModel

  # SCOPES

  ranks(:sort_order)
  default_scope { current_tenant.rank(:sort_order) }

  # ATTRIBUTES

  attr_accessor :sort_order_position

  def enqueue!(&block)
    if customer.summon! && update_attributes(state: ENQUEUED, enqueued_at: Time.now)
      block.call if block_given?
    end
  end

end
