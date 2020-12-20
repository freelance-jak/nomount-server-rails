class Api::PresentationsController < ApplicationController
  before_action :set_presentation, only: %i[show update destroy]

  # GET /presentations
  def index
    @presentations = Presentation.all
    render json: @presentations, each_serialiser: PresentationSerializer
  end

  # GET /presentations/1
  def show
    render json: @presentation, serialiser: PresentationSerializer
  end

  # POST /presentations
  def create
    @presentation = Presentation.new(presentation_params)
    if @presentation.save
      render json: @presentation, status: :created, location: @presentation, serializer: PresentationSerializer
    else
      render json: @presentation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /presentations/1
  def update
    if @presentation.update(presentation_params)
      render json: @presentation, serializer: PresentationSerializer
    else
      render json: @presentation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /presentations/1
  def destroy
    @presentation.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_presentation
    @presentation = Presentation.find_by_id(params[:id])
    return render json: {message: 'プレゼンテーションがありません'} if @presentation.blank?
  end

  # Only allow a trusted parameter "white list" through.
  def presentation_params
    params.require(:presentation).permit(:title, :presen_date, :document_path)
  end
end
