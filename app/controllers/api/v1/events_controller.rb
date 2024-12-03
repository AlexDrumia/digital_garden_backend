module Api
  module V1
    class EventsController < ApplicationController
      before_action :set_event, only: [ :show, :update, :destroy ]

      def index
        @events = Event.includes(:categories, :organizer).all

        if params[:search].present?
          @events = @events.search_full_text(params[:search])
        end

        @events = @events.joins(:categories).where("categories.name ILIKE ?", "%#{params[:category]}%") if params[:category].present?
        @events = @events.where(organizer_id: params[:organizer_id]) if params[:organizer_id].present?
        @events = @events.where(price: price_range) if price_range.present?
        @events = @events.where(kid_friendly: params[:kid_friendly]) if params[:kid_friendly].present?
        @events = @events.where(start_datetime: time_range) if time_range.present?

        if params[:sort_by].present? && [ "start_datetime", "price" ].include?(params[:sort_by])
          @sort_by = params[:sort_by]
          @events = @events.order("#{params[:sort_by]} #{sort_direction}")
        else
          @sort_by = "start_datetime"
          @events = @events.order(start_datetime: :asc)
        end

        @events = @events.page(params[:page] || 1).per(params[:per_page] || 20)

        render json: {
          total_results: @events.total_count,
          total_pages: @events.total_pages,
          current_page: @events.current_page,
          per_page: @events.limit_value,
          offset: @events.offset_value,
          sort_by: @sort_by,
          direction: sort_direction,
          records: @events.map { |event| EventSerializer.new(event).as_json }
        }
      end

      def show
        render json: @event
      end

      def create
        @event = Event.new(event_params)

        if @event.save
          render json: @event, status: :created
        else
          render json: { errors: @event.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def update
        if @event.update(event_params)
          render json: @event
        else
          render json: { errors: @event.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def destroy
        @event.destroy
        head :no_content
      end

      private

        def set_event
          @event = Event.includes(:categories, :organizer).find(params[:id])
          render json: { error: "Event not found" }, status: :not_found unless @event
        end

        def time_range
          return if params[:from].blank? && params[:to].blank?

          from = DateTime.parse(params[:from]) rescue 10.years.ago
          to = DateTime.parse(params[:to]) rescue 10.years.from_now

          from..to
        end

        def price_range
          return if params[:min_price].blank? && params[:max_price].blank?

          min_price = params[:min_price] || 0.to_s
          max_price = params[:max_price] || Float::INFINITY.to_s

          min_price..max_price
        end

        def sort_direction
          [ "asc", "desc" ].include?(params[:sort_direction]) ? params[:sort_direction] : "asc"
        end

        def event_params
          params.require(:event).permit(:name, :description, :start_datetime,
                                        :end_datetime, :organizer_id,
                                        :price, :kid_friendly, :event_url,
                                        :location)
        end
    end
  end
end
