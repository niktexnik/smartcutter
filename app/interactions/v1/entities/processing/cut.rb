module V1
  module Entities
    module Processing
      class Cut
        include Dry::Monads[:result, :do]
        include DryInteractions::InteractionErrors
        def call(mediaset)
          @mediaset = mediaset
          cut_photo
          FileUtils.rm_rf(images_tmp_folder)
          Success(@mediaset)
        end

        private

        def cut_photo
          entities.each do |entity|
            @entity = entity
            photo = MiniMagick::Image.open(entity.original_photo.photo.path).path
            result = ImageProcessor.process_image(photo, images_tmp_folder, format: settings.output_extension)
            new_photo = MiniMagick::Image.open(result)
            entity.create_cutted_photo(photo: new_photo, entity:)
          end
        end

        def entities
          @entities ||= @mediaset.entities
        end

        def settings
          @settings ||= @mediaset.product.products_setting
        end

        def images_tmp_folder
          @images_tmp_folder ||= begin
            path = Pathname.new(Rails.root.join('temp', @entity.id.to_s))
            FileUtils.mkdir_p(path)
            path
          end
        end
      end
    end
  end
end
