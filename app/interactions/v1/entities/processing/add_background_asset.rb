module V1
  module Entities
    module Processing
      class AddBackgroundAsset
        include Dry::Monads[:result, :do]
        include DryInteractions::InteractionErrors
        def call(entity)
          @entity = entity
          @asset = entity.mediaset.product.background_asset
          add_asset
          FileUtils.rm_rf(images_tmp_folder)
          Success()
        end

        private

        def processed_photo
          @processed_photo ||= MiniMagick::Image.open(@entity.processed_photo.photo.path)
        end

        def background_image
          @background_image ||= MiniMagick::Image.open(@asset.image.path)
        end

        def calculate_ofset
          bg_width, bg_height = background_image.dimensions
          processed_width, processed_height = processed_photo.dimensions
          x_offset = (bg_width - processed_width) / 2
          y_offset = (bg_height - processed_height) / 2
          [x_offset, y_offset]
        end

        def add_asset
          output_file_path = images_tmp_folder.join("#{@entity.name}-#{@entity.id}.png").to_s
          processed_photo.resize("#{background_image.dimensions[0]}x") if processed_photo.dimensions[0] != background_image.dimensions[0]

          result = background_image.composite(processed_photo) do |c|
            c.compose 'Over'
            c.geometry "+#{calculate_ofset[0]}+#{calculate_ofset[1]}"
          end
          result.write(output_file_path)
          update_processed_photo(output_file_path)
        end

        def update_processed_photo(result)
          @entity.processed_photo.update(photo: File.open(result))
        end

        def images_tmp_folder
          @images_tmp_folder ||= begin
            path = Rails.root.join('temp', 'background', @entity.id.to_s)
            FileUtils.mkdir_p(path)
            path
          end
        end
      end
    end
  end
end
