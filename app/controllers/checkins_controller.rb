class CheckinsController < ApplicationController
  before_action :set_checkin, only: [:show, :edit, :update, :destroy]

  # GET /checkins
  # GET /checkins.json
  def index
    @church_count = Church.count
    @church = Church.first
    @checkin_dates = []
    @checkin_hash = {} #date,attendees
      Checkin.all.order(created_at: :desc).each do |c|
        @checkin_dates << c.short_date 
      end
    # GET changed list of unique dates!
    @checkin_dates.uniq!
    @checkins = Checkin.all.order(created_at: :desc)
    @checkedin_users = []
    @checkin_dates.each do |d|
      count = Checkin.all.where('short_date' => d).count
      @checkin_hash.store(d,count)   
    end
    # HOW MANY PPL PER DAY
  end

  # GET /checkins/1
  # GET /checkins/1.json
  def show
  end

  # GET /checkins/new
  def new
    @church = Church.first
    @checkin = Checkin.new
  end

  # GET /checkins/1/edit
  def edit
  end

  def alert
    @day = params[:d]
    
    respond_to do |format|
    if UserMailer.alert(@day).deliver
      format.html do
        redirect_to '/'
      end
    else

    end
  end
  end

  def checkin
    @church = Church.first
    userid = current_user
    if params[:uid]
      userid = User.find(params[:uid])
    end

  #if current_user
    if Checkin.where('short_date' => Time.now.strftime("%m/%d/%Y")).where(:user => userid).count > 0
      # Already Checked in!
      respond_to do |format|
        format.html { redirect_to root_url, notice: 'We already checked you in!' }
        format.text { redirect_to root_url, notice: 'We already checked you in!' }
        format.json { render :show, status: :created, location: @checkin }
      end
    else
      #Check in!
      @checkin = Checkin.new(:user => userid, :short_date => Time.now.strftime("%m/%d/%Y"))
      respond_to do |format|
      if @checkin.save
        format.html { redirect_to root_url, notice: 'Check-In Successful!' }
        format.text { redirect_to root_url, notice: 'Check-In Successful!' }
        format.json { render :show, status: :created, location: @checkin }
      else
        format.html { render :new }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
      end
    end
 end

  # POST /checkins
  # POST /checkins.json
  def create
    @checkin = Checkin.new(checkin_params)

    respond_to do |format|
      if @checkin.save
        format.html { redirect_to @checkin, notice: 'Checkin was successfully created.' }
        format.json { render :show, status: :created, location: @checkin }
      else
        format.html { render :new }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /checkins/1
  # PATCH/PUT /checkins/1.json
  def update
    respond_to do |format|
      if @checkin.update(checkin_params)
        format.html { redirect_to @checkin, notice: 'Checkin was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkin }
      else
        format.html { render :edit }
        format.json { render json: @checkin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkins/1
  # DELETE /checkins/1.json
  def destroy
    @checkin.destroy
    respond_to do |format|
      format.html { redirect_to checkins_url, notice: 'Checkin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def list
     @church_count = Church.count
    @church = Church.first
    @datetoshow = params[:for]
    @checkins = Checkin.all.where('short_date' => @datetoshow)
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkin
      @checkin = Checkin.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkin_params
      params.require(:checkin).permit(:user_id,:uid)
    end
end
