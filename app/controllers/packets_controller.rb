class PacketsController < ApplicationController

    before_action :authenticate_user!
    before_action :set_packet, only: [:show, :edit, :update, :destroy]

    # GET /packets
    # GET /packets.json
    def index
      @packets = Packet.all
    end

    def dashboard
      @packets1 = Packet.find_by_sql(
          ['Select id, packet_name, status, deadline, start_date, expenses, description From
              (Select id, packet_name, status, deadline, start_date, expenses, description From packets Where projects_id = ? AND status =0) as packet
            join
              (Select users_id, packets_id, users_roles FROM user_packets Where (users_id = ? OR users_roles is null))as  u
            on u.packets_id = packet.id;', params[:id], current_user.id ])
      @packets2 = Packet.find_by_sql(

          ['Select id, packet_name, status, deadline, start_date, expenses, description From
              (Select id, packet_name, status, deadline, start_date, expenses, description From packets Where projects_id = ? AND status =1)as  packet
            join
              (Select users_id, packets_id, users_roles FROM user_packets Where (users_id = ? OR users_roles is null))as u
            on u.packets_id = packet.id;', params[:id], current_user.id ])
      @packets3 = Packet.find_by_sql(
          ['Select id, packet_name, status, deadline, start_date, expenses, description From
              (Select id, packet_name, status, deadline, start_date, expenses, description From packets Where projects_id = ? AND status =2) as packet
            join
              (Select users_id, packets_id, users_roles FROM user_packets Where (users_id = ? OR users_roles is null)) as u
            on u.packets_id = packet.id;', params[:id], current_user.id ])
      @packets4 = Packet.find_by_sql(
          ['Select id, packet_name, status, deadline, start_date, expenses, description From
              (Select id, packet_name, status, deadline, start_date, expenses, description From packets Where projects_id = ? AND status =3) as packet
            join
              (Select users_id, packets_id, users_roles FROM user_packets Where (users_id = ? OR users_roles is null))as u
            on u.packets_id = packet.id;', params[:id], current_user.id ])

    end

    # GET /packets/1
    # GET /packets/1.json
    def show
    end

    # GET /packets/new
    def new
      @packet = Packet.new
    end

    # GET /packets/1/edit
    def change
      @packet = Packet.all
    end

    # POST /packets
    # POST /packets.json
    def create
      @packet = Packet.new(packet_params)
      @packet.status= :task
      respond_to do |format|
          if @packet.save
            @user_packet = UserPacket.new(:users_id => current_user.id, :packets_id => @packet.id)
            if @user_packet.save
              if params[:commit] == 'Paket erstellen'
                format.html {redirect_to :controller => 'packets', :action => 'new', :id => @packet.projects_id, :flash => { :success => "Packet_created" }}
              else  params[:commit] == 'Weiter'
                format.html { redirect_to :controller => 'packets', :action => 'dashboard', :id => @packet.projects_id, :flash => { :success => "ended_packet_creation" }}
              end
            format.json { render :show, status: :created, location: @packet }
            end
          else
            format.html { render :new }
            format.json { render json: @packet.errors, status: :unprocessable_entity }
          end
      end
    end

    # PATCH/PUT /packets/1
    # PATCH/PUT /packets/1.json

    def update
      @packets = Packet.find(params[:packet][:packets_id])
      if params[:commit] =='Aufgabe bearbeiten'
        @packets.packet_name= params[:packet][:packet_name]
        @packets.start_date = params[:packet][:start_date]
        @packets.deadline = params[:packet][:deadline]
        @packets.description = params[:packet][:description]
        @packets.expenses = params[:packet][:expenses]
        respond_to do |format|
          if @packets.save
            format.html { redirect_to :controller => 'packets', :action => 'dashboard', :id => @packet.projects_id, :flash => { :success => "packet_updated" }}
            format.json { render :show, status: :ok, location: @packet }
          else
            format.html { render :edit }
            format.json { render json: @packet.errors, status: :unprocessable_entity }
          end
        end
      elsif params[:commit] == "Aufgabe annehmen"
        @user_packets = UserPacket.where(:packets_id => params[:packet][:packets_id]).take
        @packets.status = :working
        @user_packets.users_id = current_user.id
        respond_to do |format|
          if @packets.save && @user_packets.save
              format.html { redirect_to :controller => 'packets', :action => 'dashboard', :id => @packet.projects_id, :flash => { :success => "task_accepted" }}
              format.json { render :show, status: :ok, location: @packet }
            else
              format.html { render :edit }
              format.json { render json: @packet.errors, status: :unprocessable_entity }
            end
        end
      elsif params[:commit] ==  "Aufgabe abschließen"
        @packets.status = :completed
        respond_to do |format|
          if @packets.save
            format.html { redirect_to :controller => 'packets', :action => 'dashboard', :id => @packet.projects_id, :flash => { :success => "task_completed" }}
            format.json { render :show, status: :ok, location: @packet }
          else
            format.html { render :edit }
            format.json { render json: @packet.errors, status: :unprocessable_entity }
          end
        end

      elsif params[:commit] ==  "Fehler melden"
        @packets.status = :problem
        respond_to do |format|
          if @packets.save
            format.html { redirect_to new_comment_url :controller => 'comments', :action => 'new', :id => @packet.id, :flash => { :success => "problem_added" }}
            format.json { render :show, status: :ok, location: @packet }
          else
            format.html { render :edit }
            format.json { render json: @packet.errors, status: :unprocessable_entity }
            end
        end
      elsif params[:commit] ==  "Löschen"
        respond_to do |format|
          if Packet.destroy_all(:id => @packets.id)
            format.html { redirect_to :controller => 'packets', :action => 'dashboard', :id => @packet.projects_id, :flash => { :success => "packet_deleted" }}
            format.json { render :show, status: :ok, location: @packet }
          else
            format.html { render :edit }
            format.json { render json: @packet.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    # DELETE /packets/1
    # DELETE /packets/1.json
    def destroy
      @packet.destroy
      respond_to do |format|
        format.html { redirect_to packets_url, notice: 'Packet was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_packet
      @packet = Packet.find(params[:packet][:packets_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def packet_params
      params.require(:packet).permit(:packet_name, :expenses, :start_date, :deadline, :description, :projects_id)
    end
  end



