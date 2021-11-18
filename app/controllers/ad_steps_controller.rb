class AdStepsController < ApplicationController
  include Wicked::Wizard
  steps :image_step, :phone_step

  def show
    @ad = Ad.find(params[:ad_id])
    render_wizard
  end

  def update
    @ad = Ad.find(params[:ad_id])
    case step
      when :image_step
        if ((params[:ad]).present?)
          @ad.images.attach(params[:ad][:images])
        end
      render_wizard(@ad,{},ad_id: @ad)
      when :phone_step
        @ad.update(ad_params)
        redirect_to @ad
    end
  end

  def destroy
    @ad = Ad.find(params[:ad_id])
    @img = @ad.images.find(params[:picture])
    @img.purge
    redirect_to ad_steps_url(:image_step, ad_id: @ad), alert: "Image deleted successfully"
  end

  private

  def ad_params
    params.require(:ad).permit(:primary_contact, :secondary_contact)
  end
end

