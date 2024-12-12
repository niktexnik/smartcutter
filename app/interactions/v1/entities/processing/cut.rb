module V1
  module Entities
    module Processing
      class Cut
        include Dry::Monads[:result, :do]
        include DryInteractions::InteractionErrors

        def call(mediaset)
          @mediaset = mediaset

          create_cutted_photos
          create_additional_photos if process_types.present?
          cleanup_tmp_folder

          Success(@mediaset)
        end

        private

        def create_cutted_photos
          entities.each do |entity|
            photo_path = entity.original_photo.photo.path
            new_photo_path = ImageProcessor.process_image(photo_path, images_tmp_folder(entity), format: settings.output_extension)
            entity.create_cutted_photo(photo: MiniMagick::Image.open(new_photo_path), entity:)
          end
        end

        def create_additional_photos
          entities.each do |entity|
            cut_photo_path = entity.cutted_photo.photo.path
            new_photo_path = cut_photo_path

            process_types.each do |type|
              new_photo_path = ImageProcessor.process_image(new_photo_path, images_tmp_folder(entity), process_type: type, format: settings.output_extension)
              photo_type = type == 'add_shadows' ? 'shadows' : type
              entity.send("create_#{photo_type}_photo", photo: MiniMagick::Image.open(new_photo_path), entity:)
            end
          end
        end

        def process_types
          %w[blure_plates tint_windows add_shadows].select do |type|
            settings.public_send(type)
          end
        end

        def entities
          @entities ||= @mediaset.entities
        end

        def settings
          @settings ||= @mediaset.product.products_setting
        end

        def images_tmp_folder(entity)
          path = Rails.root.join('temp', entity.id.to_s)
          FileUtils.mkdir_p(path)
          path
        end

        def cleanup_tmp_folder
          entities.each do |entity|
            FileUtils.rm_rf(images_tmp_folder(entity))
          end
        end
      end
    end
  end
end
