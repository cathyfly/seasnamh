class BeachesController < ApplicationController
  before_action :set_beach, only: %i[ show edit update destroy ]

  #before_action :authenticate_user!
  #before_action :ensure_admin,only:[:destroy,:create]

  # GET /beaches or /beaches.json
  def index


    require 'net/http'
    require 'json'
    require 'uri'
    require 'openssl'
    require 'bigdecimal'
    require 'bigdecimal/util'

    # @url= 'https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=53.2895&lon=-6.1137'
    #@uri= URI(@url)
    #@response = Net::HTTP.get((@uri),{'User-Agent' => 'https://github.com/cathyfly/sea'})
    #@output = JSON.parse(@response)




    #@url_tides = 'https://tides.p.rapidapi.com/tides?latitude=53.2895&longitude=-6.1377&duration=1440&interval=60'
    #@uri_tides= URI(@url_tides)
    #http = Net::HTTP.new(@uri_tides.host, @uri_tides.port)
    #http.use_ssl = true
    #http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    #request = Net::HTTP::Get.new(@uri_tides)
    #@response_tides = Net::HTTP.get((URI.parse(@url_tides)),{'x-rapidapi-key' => 'b9b9f82b5bmshea905148572a99ap1c64c2jsn4c6d561ef553','x-rapidapi-host'=>'tides.p.rapidapi.com'})

    #request["x-rapidapi-key"] = 'b9b9f82b5bmshea905148572a99ap1c64c2jsn4c6d561ef553'
    #request["x-rapidapi-host"] = 'tides.p.rapidapi.com'

    #response = http.request(request)
    #puts response.read_body

    #@output_tides = JSON.parse(@response_tides)




    @beaches = Beach.all


    @lat_beach=@beaches[8].to_f
    @long_beach=params[:long].to_f



    @url= "https://api.met.no/weatherapi/locationforecast/2.0/compact?lat=#{@lat_beach}&lon=#{@long_beach}"
    @uri=URI(@url)
    @response = Net::HTTP.get((@uri),{'User-Agent' => 'https://github.com/cathyfly/sea'})
    @weather=JSON.parse(@response)

    if@weather.empty?
      @final_weather="Error"
    else
      @final_weather=@weather
    end


    @url_tides = "https://tides.p.rapidapi.com/tides?latitude=#{@lat_beach}&longitude=-#{@long_beach}&duration=1440&interval=60"
    @uri_tides= URI(@url_tides)
    http = Net::HTTP.new(@uri_tides.host, @uri_tides.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    request = Net::HTTP::Get.new(@uri_tides)
    @response_tides = Net::HTTP.get((URI.parse(@url_tides)),{'x-rapidapi-key' => 'b9b9f82b5bmshea905148572a99ap1c64c2jsn4c6d561ef553','x-rapidapi-host'=>'tides.p.rapidapi.com'})

    request["x-rapidapi-key"] = 'b9b9f82b5bmshea905148572a99ap1c64c2jsn4c6d561ef553'
    request["x-rapidapi-host"] = 'tides.p.rapidapi.com'

    response = http.request(request)
    puts response.read_body

    @output_tides = JSON.parse(@response_tides)
  end






  # GET /beaches/1 or /beaches/1.json
  def show
  end

  # GET /beaches/new
  def new
    @beach = Beach.new
  end

  # GET /beaches/1/edit
  def edit
  end

  # POST /beaches or /beaches.json
  def create
    @beach = Beach.new(beach_params)

    respond_to do |format|
      if @beach.save
        format.html { redirect_to @beach, notice: "Beach was successfully created." }
        format.json { render :show, status: :created, location: @beach }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @beach.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /beaches/1 or /beaches/1.json
  def update
    respond_to do |format|
      if @beach.update(beach_params)
        format.html { redirect_to @beach, notice: "Beach was successfully updated." }
        format.json { render :show, status: :ok, location: @beach }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @beach.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /beaches/1 or /beaches/1.json
  def destroy
    @beach.destroy
    respond_to do |format|
      format.html { redirect_to beaches_url, notice: "Beach was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    if params[:search].blank?
      redirect_to beaches_path and return
    else
      @parameter = params[:search].downcase
      @matchBeaches = Beach.all.where("lower(description) LIKE :search", search: "%#{@parameter}%")
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_beach
      @beach = Beach.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def beach_params
      params.require(:beach).permit(:title, :description, :location, :tide_dependency, :water_quality, :water_quality_date, :warnings, :rating, :lat, :long)
    end


end
