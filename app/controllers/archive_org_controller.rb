class ArchiveOrgController < ApplicationController
  before_filter :authenticate_user!
  
  def setup
    @shelf = Shelf.where(:id => params[:id])
    @transfer = ArchiveOrgTransfer.new(transfer_params)
  end

  def initiate
    @shelf = Shelf.where(:id => params[:id])
    @transfer = ArchiveOrgTransfer.new(transfer_params.permit(:start_year, :end_year))
    if @transfer.valid?
      @transfer.initiate
    else
      render :setup
    end
  end

protected
  def transfer_params
    if params[:transfer]
      params[:transfer].slice(:start_year, :end_year)
    else
      {}
    end
  end  
end
