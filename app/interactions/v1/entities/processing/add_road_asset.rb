module V1
  module Entities
    module Processing
      class AddRoadAsset
        include Dry::Monads[:result, :do]
        include DryInteractions::InteractionErrors
        def call(entity)
          @entity = entity
          @asset = entity.mediaset.product.road_asset
          add_asset
          FileUtils.rm_rf(images_tmp_folder)
          Success()
        end

        private

        def processed_photo
          @processed_photo ||= MiniMagick::Image.open(@entity.processed_photo.photo.path)
        end

        def road_asset
          @road_asset ||= MiniMagick::Image.open(@asset.image.path)
        end

        def calculate_ofset
          bg_width, bg_height = road_asset.dimensions
          processed_width, processed_height = processed_photo.dimensions
          x_offset = (bg_width - processed_width) / 2
          y_offset = (bg_height - processed_height) / 2
          [x_offset, y_offset]
        end

        def add_asset
          output_file_path = images_tmp_folder.join("#{@entity.name}-#{@entity.id}.png").to_s
          road_asset.resize("#{processed_photo.width}x") if road_asset.width != processed_photo.width
          result = road_asset.composite(processed_photo) do |c|
            c.compose 'Over'
            c.geometry "+#{calculate_ofset[0]}+-215"
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
