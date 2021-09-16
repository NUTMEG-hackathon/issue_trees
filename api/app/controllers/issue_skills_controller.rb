class IssueSkillsController < ApplicationController
  before_action :set_issue_skill, only: %i[ show edit update destroy ]

  # GET /issue_skills or /issue_skills.json
  def index
    @issue_skills = IssueSkill.all
    render json: @issue_skills
  end

  # GET /issue_skills/1 or /issue_skills/1.json
  def show
  end

  # GET /issue_skills/new
  def new
    @issue_skill = IssueSkill.new
  end

  # GET /issue_skills/1/edit
  def edit
  end

  # POST /issue_skills or /issue_skills.json
  def create
    @issue_skill = IssueSkill.new(issue_skill_params)
    @issue_skill.save
    render json: @issue_skill

    # respond_to do |format|
    #   if @issue_skill.save
    #     format.html { redirect_to @issue_skill, notice: "Issue skill was successfully created." }
    #     format.json { render :show, status: :created, location: @issue_skill }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @issue_skill.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /issue_skills/1 or /issue_skills/1.json
  def update
    @issue_skill.update(issue_skill_params)
    render json: @issue_skill
    # respond_to do |format|
    #   if @issue_skill.update(issue_skill_params)
    #     format.html { redirect_to @issue_skill, notice: "Issue skill was successfully updated." }
    #     format.json { render :show, status: :ok, location: @issue_skill }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @issue_skill.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /issue_skills/1 or /issue_skills/1.json
  def destroy
    @issue_skill.destroy
    respond_to do |format|
      format.html { redirect_to issue_skills_url, notice: "Issue skill was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue_skill
      @issue_skill = IssueSkill.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def issue_skill_params
      params.require(:issue_skill).permit(:issue_id, :skill_id)
    end
end
