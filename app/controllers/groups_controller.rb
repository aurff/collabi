class GroupsController < ApplicationController
  before_action :set_group, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    @groups = Group.all
  end

  # GET /groups/1
  # GET /groups/1.json
  def show
    @groups = Group.find(params[:id])
  end
  
  def showAll
    if (params.has_key?(:course_name) && !params[:course_name].blank?)
      @groups = Group.where("course = '#{params[:course_name]}'").where("university = '#{params[:university_ID]}'")
      @universities = University.all
    elsif (params.has_key?(:university_ID) && params[:course_name].blank?)
      @groups = Group.where("university = '#{params[:university_ID]}'").where("course = '#{params[:course_name]}'")
      @selected_university = params[:university_ID]
      @universities = University.all
    else
      @groups = Group.all
      @universities = University.all
    end
  end
  
  # GET /groups/new
  def new
    @group = Group.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @group = Group.new(group_params)
    respond_to do |format|
      if @group.save
        addFirstUserToGroup(@group.id)
        format.html { redirect_to @group, notice: 'Group was successfully created.' }
        format.json { render :show, status: :created, location: @group }
      else
        format.html { render :new }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @group.update(group_params)
        format.html { redirect_to @group, notice: 'Group was successfully updated.' }
        format.json { render :show, status: :ok, location: @group }
      else
        format.html { render :edit }
        format.json { render json: @group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @group.destroy
    respond_to do |format|
      format.html { redirect_to groups_url, notice: 'Group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def addFirstUserToGroup(groupID)
    @newuser = Group.find(groupID)
    @newuser.user = @newuser.user + current_user.username
    @newuser.save
  end
  
  def addUserToGroup()
    @newuser = Group.find(params[:groupID])
    if @newuser.user = ""
      @newuser.user = current_user.username
    else
      @newuser.user = @newuser.user + ',' + current_user.username
    end
    @newuser.save
        redirect_to @newuser, notice: 'Gruppe beigetreten'
  end
  
  def removeUserFromGroup()
    @removedFromGroup = Group.find(params[:groupID])
    @removedFromGroup.user = @removedFromGroup.user.remove(current_user.username)
    @removedFromGroup.save
    @removedFromGroup.user = @removedFromGroup.user.sub(",,", ",")
    #@removedFromGroup.maxMember += 1
    @removedFromGroup.save
    redirect_to action: "showAll", notice: "Aus Gruppe ausgetreten"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group
      @group = Group.find(params[:id])
      rescue ActiveRecord::RecordNotFound
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_params
      params.require(:group).permit(:name, :title, :description, :owner, :maxMember, :university, :course, :term)
    end
end
