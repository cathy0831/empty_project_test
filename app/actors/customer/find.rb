class Customer::Find < Actor
  input :customer_id

  output :customer

  def call
    self.customer = Customer.find_by(id: customer_id)

    return if customer.present?

    fail!(error: I18n.t("actor.customer.not_found", id: customer_id))
  end
end
