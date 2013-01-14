class EtkhProfilesController < ApplicationController
  load_and_authorize_resource :only => [:new,:create,:edit,:update,:destroy]

  def new     #this is not triggered when a new member signs up
    if current_user.nil?
      raise CanCan::AccessDenied.new("You need to create an account first!", :create, EtkhProfile)
    end

    if current_user.etkh_profile.nil?
      # create a new profile for the user
      @etkh_profile = EtkhProfile.new
      current_user.etkh_profile = @etkh_profile

      # fire off an email informing 80k team (join@80k..)
      EtkhProfileMailer.tell_team(current_user).deliver!

      # send an email to the user
      EtkhProfileMailer.thank_applicant(current_user).deliver!

      # add name to 'show your support'
      @supporter = Supporter.new(:name => current_user.name, :email => current_user.email)
      @supporter.save

      redirect_to members_survey_path
    else
      # user already has a profile but has visited /members/new
      render 'edit'
    end
    @menu_root = "Membership"
    @menu_current = "Join now"
  end

  def index
    get_grouped_profiles

    @menu_root = "Our community"
    @menu_current = "Our members"
    @title = "Members"
  end

  def get_grouped_profiles
    @profiles = EtkhProfile.all.to_a.sort_by{|p| p.user.name[0].upcase }
    @grouped_profiles = @profiles.group_by{ |profile| profile.user.name[0].upcase }
    @newest_profiles = EtkhProfile.newest.limit(8)
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
    @donations = @user.donations.confirmed
    @profile = @user.etkh_profile

    @menu_root = "Our community"
    @menu_current = "Our members"
  end

  def destroy
    profile = EtkhProfiles.find( params[:id] )
    if profile.destroy
      flash[:"alert-success"] = "Deleted profile"
    else
      flash[:"alert-error"] = "Failed to delete profile!"
    end
    redirect_to users_path
  end

  def edit
    @etkh_profile = current_user.etkh_profile
  end

  def update
    if current_user.update_attributes(params[:user])
      flash[:"alert-success"] = "Your profile was successfully updated."
      
      #work out time since user profile was first created
      timediff = Time.now - current_user.confirmed_at   #in seconds
      timediff = timediff / 60  #in minutes

      #if much time has elapsed since the profile was created
      maxTime = 60 #minutes
      if timediff > maxTime
        #assume the user is editing their profile
        redirect_to( etkh_profile_path( current_user ) )
      else
        #assume the user is creating their profile for the first time
        redirect_to( members_survey_path )
      end
    else
      render :action => "edit"
    end
  end

  def search
    @user = User.find_by_name(params[:name])
    if @user
      redirect_to etkh_profile_path(@user)
    else
      flash[:"alert-error"] = "Couldn't find #{params[:name]}!"
      redirect_to :action => :index
    end
  end

end
