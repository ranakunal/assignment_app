class ImportController < ApplicationController
    def new
      @import = Import.new
      render layout: false
    end

    def create
      @import = Import.new(import_params)
      if @import.save
        ImportProductsJob.perform_later(@import.id)
      else
        render plain: "error"
      end
      redirect_to root_path
    end

    private
    def import_params
        params.require(:product).permit(:attachment)
    end
end
