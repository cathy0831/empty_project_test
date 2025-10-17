class Customer::Update < Actor
  input :customer_id
  input :params

  output :customer

  def call
    self.customer = Customer.find_by(id: customer_id)

    return fail!(error: I18n.t("actor.customer.not_found", id: customer_id)) if customer.blank?

    return if customer.update(customer_params)

    fail!(error: customer.formatted_errors)
  end

  private

  def customer_params
    params.permit(
      :account,
      :name,
      :password,
      :permission_id,
      :note,
      :state,
    )
  end
end
