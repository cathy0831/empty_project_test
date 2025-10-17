class Setting::CustomersController < ApplicationController
  before_action -> { permission_check("customer", "search") }, only: [:index]
  before_action -> { permission_check("customer", "edit") }, except: [:index]
  before_action :raleted_data, only: [:index, :new, :edit]

  def index
    actor = Customer::List.result(search_params)
    if actor.success?
      @pagy, customers = pagy_array(actor.customers)
      @customers = customer_blueprint(customers, view: :list)
    else
      @customers = []
    end
  end

  def new
    @customer = Customer.new(state: "enable")
  end

  def edit
    actor = Customer::Find.result(customer_id: params[:id])
    if actor.success?
      @customer = customer_blueprint(actor.customer, view: :form)
    else
      head :not_found
    end
  end

  def create
    actor = Customer::Create.result(form_params)
    render_json(actor)
  end

  def update
    actor = Customer::Update.result(form_params)
    render_json(actor)
  end

  private

  def raleted_data
    permissions = Permission::List.call.permissions
    @permissions = PermissionBlueprint.render_as_hash(permissions)
  end

  def customer_blueprint(customers, view: nil)
    CustomerBlueprint.render_as_hash(customers, view:)
  end

  def search_params
    {
      type: "setting",
      account: params[:account],
      name: params[:name],
    }
  end

  def form_params
    {
      customer_id: params[:id],
      params: params.permit(:account,
                            :name,
                            :password,
                            :permission_id,
                            :note,
                            :state),
    }
  end
end
