class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json

  def index
    @events = Event.find_by_sql(
        ['
       select id,title,description,start_time,end_time
FROM
  (
    SELECT
      id,
      project_name AS title,
      description  AS description,
      start_date   AS start_time,
      deadline     AS end_time
    FROM projects p5
      join user_projects as p6
        on p5.id=p6.projects_id
    where p6.users_id=?
  UNION
    SELECT
      p1.id,
      p1.packet_name  AS title,
      p2.project_name AS description,
      p1.start_date   AS start_time,
      p1.deadline     AS end_time
    FROM packets AS p1
      JOIN projects AS p2
        ON p1.projects_id = p2.id
      join user_projects as p3
        on p2.id=p3.projects_id
       where p3.users_id=?
  UNION
    SELECT
      id,
      title,
      description,
      start_time,
      end_time
    FROM events
  )g', current_user.id,current_user.id])
  end

  def show
    respond_with(@event)
  end

  def calendar
    @events = Event.find_by_sql(
        ['
            select title,description,start_time,end_time
            FROM
              (
                SELECT
                  project_name AS title,
                  description  AS description,
                  start_date   AS start_time,
                  deadline     AS end_time
                FROM projects
              UNION

                SELECT
                  p1.packet_name  AS title,
                  p2.project_name AS description,
                  p1.start_date   AS start_time,
                  p1.deadline     AS end_time
                FROM packets as p1
                join projects as p2
                  on p1.projects_id = p2.id
              UNION
                SELECT
                  title,
                  description,
                  start_time,
                  end_time
                FROM events
              );', current_user.id])
  end

  def new
    @event = Event.new
    respond_with(@event)
  end

  def edit
  end

  def create
    @event = Event.new(event_params)
    @event.save
    respond_with(@event)
  end

  def update
    @event.update(event_params)
    respond_with(@event)
  end

  def destroy
    @event.destroy
    respond_with(@event)
  end

  private
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:title, :description, :start_time, :end_time)
    end
end
