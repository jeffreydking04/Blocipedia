class ChargesController < ApplicationController
  def new
    @stripe_btn_data = {
      key: "#{ Rails.configuration.stripe[:publishable_key] }",
      description: "Premium Membership - #{current_user.email}",
      amount: 1500
    }
  end  

  def create
    customer = Stripe::Customer.create(
      email: current_user.email,
      card: params[:stripeToken]
    )
  
    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: 1500,
      description: "Premium Membership - #{current_user.email}",
      currency: 'usd'
    )
  
    flash[:notice] = "Transaction approved, #{current_user.email}!"
    current_user.update_attribute(:role, "premium")
    current_user.save!
    redirect_to wikis_path
  
    rescue Stripe::CardError => e
      flash[:alert] = e.message
      redirect_to new_charge_path
  end
end