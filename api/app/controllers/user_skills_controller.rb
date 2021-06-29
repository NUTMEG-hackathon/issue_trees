class UserSkillsController < ApplicationController
  before_action :set_user_skill, only: %i[ show edit update destroy ]

  # GET /user_skills or /user_skills.json
  def index
    @user_skills = UserSkill.all
  end

  # GET /user_skills/1 or /user_skills/1.json
  def show
  end

  # GET /user_skills/new
  def new
    @user_skill = UserSkill.new
  end

  # GET /user_skills/1/edit
  def edit
  end

  # POST /user_skills or /user_skills.json
  def create
    @user_skill = UserSkill.new(user_skill_params)

    respond_to do |format|
      if @user_skill.save
        format.html { redirect_to @user_skill, notice: "User skill was successfully created." }
        format.json { render :show, status: :created, location: @user_skill }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @user_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_skills/1 or /user_skills/1.json
  def update
    respond_to do |format|
      if @user_skill.update(user_skill_params)
        format.html { redirect_to @user_skill, notice: "User skill was successfully updated." }
        format.json { render :show, status: :ok, location: @user_skill }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user_skill.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_skills/1 or /user_skills/1.json
  def destroy
    @user_skill.destroy
    respond_to do |format|
      format.html { redirect_to user_skills_url, notice: "User skill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_skill
      @user_skill = UserSkill.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_skill_params
      params.require(:user_skill).permit(:user_id, :skill_id)
    end
end
