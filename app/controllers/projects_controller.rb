class ProjectsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_project, only: [:show, :edit, :update, :destroy], except: [:overview, :addMember, :showMember, :update]

    # GET /projects
    # GET /projects.json
    def index
      @projects = Project.all
    end

    # GET /projects/1
    # GET /projects/1.json

    def show
    end
    def showMember
      @users = User.find_by_sql(['Select first_name, last_name, email FROM
            (Select first_name, last_name, email, id from users) as  u
          JOIN
            (Select * from user_projects where projects_id = ?)as  project
          on project.users_id = u.id;', params[:id]])

    end


    def addMember

      @users = User.find_by_sql(['
            Select  u.first_name
                  , u.last_name
                  , u.email
            FROM
               (
                  Select first_name
                        , last_name
                        , email
                        , id
                    from users
               ) as u
            JOIN
              (
                Select *
                  from user_projects
                  where projects_id = ?
              ) as project
            on project.users_id = u.id;', params[:id]])

      respond_to do |format|
        if params.has_key?(:user)
          @newMembers = User.where(email: params[:user][:email].downcase! ).take
          if !(@newMembers.nil?)
            @user_projects = UserProject.new(:users_id => @newMembers.id, :projects_id => params[:id], :users_roles => :member)

              if @user_projects.save
                  if params[:commit] == 'Add'
                    format.html {
                      redirect_to addMember_url :controller => 'projects', :action => 'showMember', :id => params[:id], :flash =>  { :success => "added_user" } }
                  elsif params[:commit] == 'Weiter'
                    format.html {
                     redirect_to :controller => 'packets', :action => 'new', :id => params[:id], :flash => { :success=> "user_adding_completed" }}
                  end
                format.json { render :member, status: :created, location: @user_project }
              else
                format.html {redirect_to :controller => 'packets', :action => 'new', :id => params[:id], :flash => { :failed => "error_add_user" }}
                format.json { render json: @project.errors, status: :unprocessable_entity }
              end
          else
            format.html {
              redirect_to :controller => 'packets', :action => 'new', :id => params[:id], :flash => { :failed => "user_adding_completed" }}
          end
        end
      end
    end

    def overview

      @projects = Project.find_by_sql(
          ['Select  p.id as pid
                  , project_name
                  , description
                  , start_date
                  , deadline
                  , first_name
                  , last_name
                  , budget
            FROM
            (
                Select
                      project.id
                    , project.project_name
                    , project.description
                    , project.start_date
                    , project.deadline
                    , project.budget
                    , userPro.users_id
                    , userPro.projects_id
                FROM
                (
                  Select  id
                      , project_name
                      , description
                      , start_date
                      , deadline
                      , budget
                  FROM projects
                ) as  project
                JOIN
                (
                  Select   users_id
                        , projects_id
                  FROM user_projects
                  where users_id = ?
                ) as userPro
                on project.id = userPro.projects_id
            ) as p
            Join
             (
              Select  userTest.first_name
                    , userTest.last_name
                    , pm.projects_id
              FROM
                (
                 Select users_id
                      , projects_id
                      , users_roles
                   FROM user_projects
                  where users_roles = 0
                ) as pm
              join
                (
                 Select  id
                       , first_name
                       , last_name
                   from users
                ) as userTest
              on pm.users_id = userTest.id
             ) as pmName
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
      respond_to do |format|
        if @project.save
          @user_project = UserProject.new(:users_id => current_user.id, :projects_id => @project.id, :users_roles => :manager)
            if @user_project.save
              format.html {
                redirect_to  addMember_url :controller => 'projects', :action => 'showMember', :id => @project.id, :flash => { :success => "Message" } }
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
      @projects = Project.find(params[:project][:projects_id])
      if params[:commit] =='Projekt bearbeiten'
        @projects.project_name= params[:project][:project_name]
        @projects.start_date = params[:project][:start_date]
        @projects.deadline = params[:project][:deadline]
        @projects.description = params[:project][:description]
        @projects.budget = params[:project][:budget]
        respond_to do |format|
          if @projects.save
            format.html { redirect_to :controller => 'projects', :action => 'overview', :flash => { :success => "project_updated" }}
            format.json { render :show, status: :ok, location: @packet }
          else
            format.html { render :edit }
            format.json { render json: @packet.errors, status: :unprocessable_entity }
          end
        end
      elsif params[:commit] == "Projekt löschen"

        respond_to do |format|
          if (Project.destroy_all(:id => params[:project][:projects_id])) && (Packet.destroy_all(:projects_id => params[:project][:projects_id]))
            format.html { redirect_to :controller => 'projects', :action => 'overview', :flash => { :success => "project_deleted" }}
            format.json { render :show, status: :ok, location: @packet }
          else
            format.html { render :edit }
            format.json { render json: @packet.errors, status: :unprocessable_entity }
          end
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


