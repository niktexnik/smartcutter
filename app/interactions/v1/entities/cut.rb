module V1
  module Entities
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
          `python3 -m backgroundremover.cmd.cli -i "#{photo}" -o "#{images_tmp_folder}/cut_car_#{entity.id}.png"`
          new_photo = MiniMagick::Image.open("#{images_tmp_folder}/cut_car_#{entity.id}.png")
          entity.create_processed_photo(photo: new_photo, entity:)
        end
      end

      def entities
        @entities ||= @mediaset.entities
      end

      def images_tmp_folder
        @images_tmp_folder ||= begin
          path = Path_name.new(Rails.root.join('temp', @entity.id.to_s))
          FileUtils.mkdir_p(path)
          path
        end
      end
    end
  end
end
