class ArchiveOrgController < ActionController::Base
  def setup
    @shelf = Shelf.where(:id => params[:id])
  end

  def initiate
    @shelf = Shelf.where(:id => params[:id])
  end
end
