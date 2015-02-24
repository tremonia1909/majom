class ProjectsController < ApplicationController


    before_action :set_project, only: [:show, :edit, :update, :destroy], except: :overview

    # GET /projects
    # GET /projects.json
    def index
      @projects = Project.all
    end

    # GET /projects/1
    # GET /projects/1.json
    def show
      @projects = Project.all
    end


    def add_user
      #@contacts = Contact.contacts
      @projectMembers = UserPacket.find_by_sql([
        'Select first_name, last_name, email FROM
            (Select * from user_projects where projects_id = ?) project
          JOIN
            (Select first_name, last_name, email, id from users) user
          on project.users_id = user.id;', params[:projects_id]])
      @newMember = User.find_by_sql(['Select id from users where email =?;', params[:email]])
      @user_project = UserProject.new(:users_id => @newMember, :projects_id => params[:projects_id], :users_roles => :member)
      @projects = Project.new(params[:projects_id])
      respond_to do |format|
        if @user_project.save
            if params[:commit] == 'Add Member'
              format.html {
                redirect_to add_user_url ,:controller => 'projects', :action => 'add_user', :id => @projects, :email => params[:email], :flash =>  { :success => "Message" } }
            else
              format.html {
                redirect_to :controller => 'packets', :action => 'new', :id => @project, :flash => { :success => "Message" }}
            end
          format.json { render :show, status: :created, location: @project }
        else
          format.html { render :new }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end

    end
    def overview

      @projects = Project.find_by_sql(
          ['Select p.id as pid, project_name, description, deadline, first_name, last_name FROM
            (Select project.id, project.project_name, project.description, project.deadline, userPro.users_id, userPro.projects_id FROM
              (Select id, project_name, description, deadline FROM projects) project
              JOIN
              (Select users_id, projects_id FROM user_projects where users_id = ?) userPro
              on project.id = userPro.projects_id) p
            Join
              (Select user.first_name, user.last_name, pm.projects_id FROM
                (Select * FROM user_projects where users_roles = 0) pm
                join
                (Select id, first_name, last_name from users) user
                on pm.users_id = user.id) pmName
            on pmName.projects_id= p.projects_id
          Order by p.projects_id ASC;', current_user.id])
    end

    # GET /projects/new
    def new
      @project = Project.new
    end

    # GET /projects/1/edit
    def edit
    end

    # POST /projects
    # POST /projects.json
    def create
      @project = Project.new(project_params)
      #@user_project.projects_id = @project.id
      #@user_project.users_id= current_user.id
      respond_to do |format|
        if @project.save
          @user_project = UserProject.new(:users_id => current_user.id, :projects_id => @project.id, :users_roles => :manager)
            if @user_project.save
              format.html {
                redirect_to add_user_url, :controller => 'projects', :action => 'add_user', :id => @project, :flash => { :success => "Message" } }
              format.json { render :show, status: :created, location: @project }
            else
              format.html { render :new }
              format.json { render json: @project.errors, status: :unprocessable_entity }
            end
          end
      end
    end

    # PATCH/PUT /projects/1
    # PATCH/PUT /projects/1.json
    def update
      respond_to do |format|
        if @project.update(project_params)
          format.html { redirect_to @project, notice: 'Project was successfully updated.' }
          format.json { render :show, status: :ok, location: @project }
        else
          format.html { render :edit }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /projects/1
    # DELETE /projects/1.json
    def destroy
      @project.destroy
      respond_to do |format|
        format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:project])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:project_name, :budget, :start_date, :deadline, :description)
    end
  end


