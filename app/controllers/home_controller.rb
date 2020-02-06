class HomeController < ApplicationController
  before_action :set_visit, only: [:show, :destroy]

  def index
    @visits = Visit.all
  end

  def collect_statistics
    json = ActiveSupport::JSON.decode(File.read('lib/api.json'))
    Visit.save_visit_and_pageviews(json)
    redirect_to action: "index"
  end

  def show
    @pageviews = @visit.pageviews
  end

  def destroy
    @visit.destroy
    respond_to do |format|
      format.html { redirect_to action: "index", notice: 'Visit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  def set_visit
    @visit = Visit.find(params[:id])
  end
end
