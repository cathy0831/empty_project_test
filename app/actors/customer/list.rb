class Customer::List < Actor
  input :type, default: "setting"
  input :account
  input :name

  output :customers

  def call
    query = Customer.includes(:permission)

    query = query.where("account LIKE ?", "%#{account}%") if account.present?
    query = query.where("name LIKE ?", "%#{name}%") if name.present?

    self.customers = query.order(:created_at)
  end
end
