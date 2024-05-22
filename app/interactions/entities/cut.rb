module Mediasets
  class Cut
    include Dry::Monads[:result, :do]
    include DryInteractions::InteractionErrors
    class Contract < ::Validations::ApplicationContract
      params do
        required(:mediaset_id).filled(:integer)
      end
    end

    def call
      mediaset(mediaset_id)
      FileUtils.rm_rf(images_tmp_folder)
    end

    private

    def cut_photo
      @entities.each do |entity|
        photo = MiniMagick::Image.open(entity.original_photo.url)
        `python3 -m backgroundremover.cmd.cli -i "#{photo}" -o "#{images_tmp_folder}/cut_car_#{entity.id}.png"`
        new_photo = MiniMagick::Image.open("#{images_tmp_folder}/cut_car_#{entity.id}.png")
        entity.processed_photo.create(photo: new_photo, entity:, mediaset: @mediaset)
      end
    end

    def mediaset(id)
      @mediaset ||= Mediaset.find(id)
    end

    def entities
      @entities ||= @mediaset.entities
    end

    def images_tmp_folder
      @images_tmp_folder ||= begin
        path = Pathname.new(Rails.root.join('temp', entity.id.to_s))
        FileUtils.mkdir_p(path)
        path
      end
    end
  end
end
