class DonationsController < ApplicationController
  load_and_authorize_resource

  def index
    @donations = Donation.confirmed
    @your_donations = current_user.donations if current_user
  end

  def create
    @donation = Donation.new(params[:donation])
    @donation.currency = params[:donation][:currency]

    if !@donation.user_id
      @donation.user_id = current_user.id
    end

    if params[:inspired_by_cea] && params[:inspired_by_cea] == "true"
      @donation.inspired_by_cea = true
    else
      @donation.inspired_by_cea = false
    end

    if @donation.save
      flash[:"alert-success"] = "Thanks #{current_user.first_name}, your donation is being processed! We'll send you an email once it's been added to your profile."
      redirect_to donations_path
    else
      render :new
    end
  end

  def new
    @donation = Donation.new( :user => current_user )
    authorize! :create, Donation, :message => "You need to <a href='/accounts/sign_in'>sign in</a> or <a href='/join'>sign up</a> to make a donation!".html_safe
  end

  def edit
    @donation = current_user.donations.find( params[:id] )
    authorize! :edit, Donation, :message => "You need to <a href='/accounts/sign_in'>sign in</a> or <a href='/join'>sign up</a> to edit a donation!".html_safe
  end

  def show
    @donation = Donation.find(params[:id])
  end

  def update
    @donation = current_user.donations.find(params[:id])

    if params[:inspired_by_cea] && params[:inspired_by_cea] == "true"
      @donation.update_attributes(inspired_by_cea: true)
    else
      @donation.update_attributes(inspired_by_cea: false)
    end

    if @donation.update_attributes(params[:donation])
      flash[:"alert-success"] = "Your donation details were updated successfully"
      redirect_to(@donation)
    else
      render :action => "edit"
    end
  end
end
