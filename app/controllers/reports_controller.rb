class ReportsController < ApplicationController
    load_resource only: [:show, :edit, :update, :destroy, :see_message, :moderate, :moderate_update]
    load_and_authorize_resource

    # GET /reports
    def index
      @message_reports = Report.includes([:listing, conversation_message: [:sender, :conversation]]).where.not(conversation_message: nil)
      @listing_reports = Report.includes([:listing, conversation_message: [:sender, :conversation]]).where.not(listing: nil)
    end
  
    # GET /reports/1
    def show
    end
  
    # GET /reports/new
    def new
      @report = Report.new
    end
  
    # GET /reports/1/edit
    def edit
    end
  
    # POST /reports
    def create
      @report = Report.new(report_params)
  
      if @report.save
        redirect_to reports_path, notice: 'Report was successfully created.'
      else
        render :new
      end
    end
  
    # PATCH/PUT /reports/1
    def update
      if @report.update(report_params)
        redirect_to reports_path, notice: 'Report was successfully updated.'
      else
        render :edit
      end
    end
  
    # DELETE /reports/1
    def destroy
      @report.destroy
      redirect_to reports_url, notice: 'Report was successfully deleted.'
    end

    def see_message
      render layout: false
    end

    def moderate
      render layout: false
    end

    def moderate_update
      
      delete_item = params[:report_options][:delete_item]
      delete_report = params[:report_options][:delete_report]
      report_outcome = params[:report_options][:outcome]
      @report.update(outcome: report_outcome, moderator: current_user)
      if delete_report == "1"
        @report.destroy
      end
      if delete_item == "1"
        if @report.listing.present?
          @report.listing.update(listing_status: ListingStatus.find_by(name: 'Deleted'), moderator: current_user)
        else
          @report.conversation_message.update(is_deleted: true)
        end
      else
        if @report.listing.present?
          @report.listing.update(listing_status: ListingStatus.find_by(name: 'Active'), moderator: current_user)
        else
          @report.conversation_message.update(is_deleted: false)
        end
      end
      redirect_to reports_path
    end
  
    private
      # Callback functions to share common setup or constraints between actions.
      def set_report
        @report = Report.find(params[:id])
      end
  
      # Only allow a trusted parameter "white list" through.
      def report_params
        params.require(:report).permite(:message, :outcome)
      end
  end