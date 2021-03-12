class ReportsController < ApplicationController
    before_action :set_report, only: [:show, :edit, :update, :destroy]
  
    # GET /reports
    def index
      @reports = Report.all
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