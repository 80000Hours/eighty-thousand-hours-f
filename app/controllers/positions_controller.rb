class PositionsController < ApplicationController
  def new
    @position = Position.new
    render 'etkh_profiles/positions/show_form'
  end

  def create
    @new_position = Position.new(params[:position])
    @new_position.etkh_profile_id = params[:position][:etkh_profile_id]
    @new_position.save

    @ordered_positions = current_user.etkh_profile.positions.order("end_date_year DESC")
    render 'etkh_profiles/positions/redraw_positions'
  end

  def edit
    @position = Position.find_by_id(params[:id])
    render 'etkh_profiles/positions/show_form'
  end

  def update
    @position = Position.find_by_id(params[:id])
    @position.update_attributes(params[:position])
    sleep(1)
    @ordered_positions = current_user.etkh_profile.positions.order("end_date_year DESC")
    render 'etkh_profiles/positions/redraw_positions'
  end

  def destroy
    @position = Position.find_by_id(params[:id])
    @position.destroy
    @ordered_positions = current_user.etkh_profile.positions.order("end_date_year DESC")
    render 'etkh_profiles/positions/redraw_positions'
  end
end