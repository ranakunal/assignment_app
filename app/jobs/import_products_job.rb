class ImportProductsJob < ApplicationJob
  queue_as :default

  def perform(attachment_id)
      ActionCable.server.broadcast("notification_channel","notify you when products are import");
      @xlsx_unique_nm = []
      import = Import.find(attachment_id)
      file_path = import.attachment.url # get full path.
      file_path = "#{Rails.root}/public/#{file_path}"
      read_file = Roo::Excelx.new(file_path)
      @all_product = []
      @handle = []
      @failed_options = {}
      @error_handles = []
      @failed_count = 0
      read_file.each_with_index do |value,index|
        if value == read_file.first
          if (value[0] != 'Handle' || value[1] != 'Title' || value[2] != 'Vendor' || value[3] != 'Type'  || value[4] != 'Tags' || value[5] != 'Variant SKU' || value[6] != 'Variant Inventory Qty' || value[7] != 'Description' || value[8] != 'Price' )
            @header_error = true
            #add notification
            break
          end
          next
        end
        if !@header_error
          @products = {}
          if !@handle.include? value[0]
            @products['handle'] = value[0]
            @handle.push(value[0])
            @products['title'] = value[1]
            @products['vendor'] = value[2]
            @products['product_type'] = value[3]
            @products['tags'] = value[4]
            @products['skus'] = value[5]
            if ((value[8].is_a? Float) || (value[8].is_a? Integer))
              @products['price'] = value[8]
            else
              @failed_options[(index+1).to_s] = ["Price must be in float or integer value",value[0]]
            end

            if (value[6].is_a? Integer)
              @products['inventory'] = value[6]
            else
              @failed_options[(index+1).to_s] = ["inventory must be integer value",value[0]]
            end

            @products['desctiption'] = value[7]

            @all_product.push(@products)
          else
            @failed_options[(index+1).to_s] = ["This handle is already present",value[0]]
            @error_handles << value[0]
            @failed_count += 1
          end
        end        
      end
      if @all_product.any?
        if Product.create(@all_product) 
          #notivfication
        end
      end
  end
end
