class Customer::Create < Actor
  input :params

  output :customer

  def call
    self.customer = Customer.new(customer_params)

    return if customer.save

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
