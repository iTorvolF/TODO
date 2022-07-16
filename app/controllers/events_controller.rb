# frozen_string_literal: true

class EventsController < ApplicationController
  include Commentable
  
  before_action :authenticate_user!
  before_action :set_event, only: %i[show edit update destroy]

  # Отображение всех созданных заданий
  def index
    Rack::MiniProfiler.step('Загрузка всех событий') do
      @all = Event.all
    end
    @events = policy_scope(Event).includes(:items).page(params[:page]).per(5)
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  # Просмотр конкретного задания
  def show
    authorize @event
    @comments = @event.comments.root.self_and_descendants.order(:lft)
  end

  # Формирует и отображает HTML-форму, которая позволяет подготовить данные для создания объекта.
  # @note Вызывается при нажатии по кнопке 'New event'
  def new
    @event = Event.new
  end

  # Редактирование задания, внесение изменений в БД
  # @note Вызывается при нажатии по кнопке 'Edit'
  def edit
    authorize @event
    I18n.locale = session.fetch(:locale, I18n.default_locale).to_sym
  end

  # Создает новый объект, проверяет его и затем сохраняет в БД
  def create
    @event = current_user.events.create(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # Создание формы редактирования
  def update
    authorize @event
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # Удаление задания
  # @note Вызывается при нажатии по кнопке 'Delete'
  def destroy
    authorize @event
    @event.destroy
    if @event.destroy.destroyed?
      redirect_to events_path
    else
      render json: @event.errors, status: :unprocessable_entity
    end
  end

  private

  # Установка задания перед действием, при помощи коллбэка
  def set_event
    @event = Event.with_attached_files.find(params[:id])
  end

  # Установка списка разрешенных параметров
  def event_params
    params.require(:event).permit(:name, :content, :finished_at, :done, files: [])
  end
end
