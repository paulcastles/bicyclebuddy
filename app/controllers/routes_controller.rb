class RoutesController < ApplicationController
  before_action :set_route, only: [:show, :edit, :update, :destroy]

  # GET /routes
  # GET /routes.json
  def index
    @routes = Route.all
  end

  # GET /routes/1
  # GET /routes/1.json
  def show
    @routes = Route.all
    @route = Route.find(params[:id])
    @against_the_wind = get_against_the_wind_percentage
  end

  # GET /routes/new
  def new
    @route = Route.new
  end

  # GET /routes/1/edit
  def edit
  end

  # POST /routes
  # POST /routes.json
  def create
    @route = Route.new(route_params)

    respond_to do |format|
      if @route.save
        format.html { redirect_to @route, notice: 'Route was successfully created.' }
        format.json { render :show, status: :created, location: @route }
      else
        format.html { render :new }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /routes/1
  # PATCH/PUT /routes/1.json
  def update
    respond_to do |format|
      if @route.update(route_params)
        format.html { redirect_to @route, notice: 'Route was successfully updated.' }
        format.json { render :show, status: :ok, location: @route }
      else
        format.html { render :edit }
        format.json { render json: @route.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /routes/1
  # DELETE /routes/1.json
  def destroy
    @route.destroy
    respond_to do |format|
      format.html { redirect_to routes_url, notice: 'Route was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_route
      logger.info "asdasdasdasdasdadsdsdasads"
      logger.info params.inspect
      @route = Route.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def route_params
      params.require(:route).permit(:name, :image)
    end
  
    def get_against_the_wind_percentage
      # wind bearing range +/- 90 deg
      windBearing = (@forecast.hourly.data.first.windBearing)
      limit1 = (windBearing - 90)%360 
      limit2 = (windBearing + 90)%360 #eg. if upper limit = 390, this will return 30
      lowerLimit = [limit1, limit2].min
      upperLimit = [limit1, limit2].max

      # loop through each point on route, calculate if direction is against/within bearing range
      countWith = 0
      countAgainst = 0
      @route.points.each_with_index do |point1, i|
        if i < @route.points.size-1  
          point2 = @route.points[i+1]
          direction = Geocoder::Calculations.bearing_between(point1, point2)
          oppositeDirection = (direction + 180)%360
          
           # keep count of each, calulate percentage against
          if (lowerLimit..upperLimit).include?(oppositeDirection.to_i)
            countAgainst+=1
          else
            countWith+=1
          end
        end
        
      end
      countAgainst*100/(countWith+countAgainst)
    end
end
