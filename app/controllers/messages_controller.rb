class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]

  # GET /messages
  # GET /messages.json
  def index
    @church = Church.first
    @messages = Message.all
    @users = User.all.where(:sms_ok => true).where.not(telephone: [nil,""],carrier_id: [nil])
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
    @church = Church.first
  end

  # GET /messages/new
  def new
    @scope = User.all.where(:sms_ok => true).count
    @church = Church.first
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @church = Church.first.name #get name of church
    @subject = "#{@church}-Alert" #set subject
    @count = User.all.where(:sms_ok => true).where.not(telephone: [nil,""],carrier_id: [nil]).count
    @message.count = @count

    UserMailer.email_blast(@subject,@message.body).deliver #deliver message
 
    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_url, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to @message, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body,:count)
    end
end
