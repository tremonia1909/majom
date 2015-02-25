class ContactsController < ApplicationController

    before_action :set_contact, only: [:show, :edit, :update, :destroy], except: [:contacts, :show, :profile]

    # GET /contacts
    # GET /contacts.json
    def profile
      @contacts = User.find(params[:id])
    end

    # GET /contacts/1
    # GET /contacts/1.json
    def show
      @contacts = User.find(current_user.id)
    end

    def contacts

      @contacts = Contact.find_by_sql(
          ['Select first_name, last_name, email, contact.contacts_id as conID FROM
            (Select * FROM contacts where persons_id = ?) contact
          JOIN
            (Select id, first_name, last_name, email FROM users) user
          on contact.contacts_id = user.id;', current_user.id])
    end

    # GET /contacts/new
    def new
      @contact = Contact.new
    end

    # GET /contacts/1/edit
    def edit
    end

    # POST /contacts
    # POST /contacts.json
    def create
      @contact = Contact.new(contact_params)
      #@user_contact.contacts_id = @contact.id
      #@user_contact.users_id= current_user.id
      respond_to do |format|
        if @contact.save
          @user_contact = UserContact.new(:users_id => current_user.id, :contacts_id => @contact.id, :users_roles => :manager)
          if @user_contact.save
            format.html {
              redirect_to :controller => 'packets', :action => 'new', :id => @contact, :flash => { :success => "Message" } }
            format.json { render :show, status: :created, location: @contact }
          else
            format.html { render :new }
            format.json { render json: @contact.errors, status: :unprocessable_entity }
          end
        end
      end
    end

    # PATCH/PUT /contacts/1
    # PATCH/PUT /contacts/1.json
    def update
      respond_to do |format|
        if @contact.update(contact_params)
          format.html { redirect_to @contact, notice: 'Contact was successfully updated.' }
          format.json { render :show, status: :ok, location: @contact }
        else
          format.html { render :edit }
          format.json { render json: @contact.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /contacts/1
    # DELETE /contacts/1.json
    def destroy
      @contact.destroy
      respond_to do |format|
        format.html { redirect_to contacts_url, notice: 'Contact was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = Contact.find(params[:contact])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contact_params
      params.require(:contact).permit( :id, :conID, :persons_id, :contacts_id)
    end

end
