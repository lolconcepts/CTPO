class PronounsController < ApplicationController
  before_action :set_pronoun, only: [:show, :edit, :update, :destroy]

  # GET /pronouns
  # GET /pronouns.json
  def index
    @pronouns = Pronoun.all
  end

  # GET /pronouns/1
  # GET /pronouns/1.json
  def show
  end

  # GET /pronouns/new
  def new
    @pronoun = Pronoun.new
  end

  # GET /pronouns/1/edit
  def edit
  end

  # POST /pronouns
  # POST /pronouns.json
  def create
    @pronoun = Pronoun.new(pronoun_params)

    respond_to do |format|
      if @pronoun.save
        format.html { redirect_to @pronoun, notice: 'Pronoun was successfully created.' }
        format.json { render :show, status: :created, location: @pronoun }
      else
        format.html { render :new }
        format.json { render json: @pronoun.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pronouns/1
  # PATCH/PUT /pronouns/1.json
  def update
    respond_to do |format|
      if @pronoun.update(pronoun_params)
        format.html { redirect_to @pronoun, notice: 'Pronoun was successfully updated.' }
        format.json { render :show, status: :ok, location: @pronoun }
      else
        format.html { render :edit }
        format.json { render json: @pronoun.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pronouns/1
  # DELETE /pronouns/1.json
  def destroy
    @pronoun.destroy
    respond_to do |format|
      format.html { redirect_to pronouns_url, notice: 'Pronoun was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pronoun
      @pronoun = Pronoun.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pronoun_params
      params.require(:pronoun).permit(:description)
    end
end
