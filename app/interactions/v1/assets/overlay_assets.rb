# module V1
#   module Assets
#     class OverlayAssets
#       include Dry::Monads[:result, :do]
#       include DryInteractions::InteractionErrors

#       private

#       def load_image(path)
#         MiniMagick::Image.open(path)
#       end

#       def overlay_image(base_image, overlay_image, offset, position: 'South')
#         base_image.composite(overlay_image) do |c|
#           c.compose 'Over'
#           c.geometry(offset_to_geometry(offset)) if offset
#           c.gravity position unless offset
#         end
#       end

#       def calculate_offset(overlay, base)
#         x_offset = (base.width - overlay.width) / 2
#         y_offset = (base.height - overlay.height) / 2
#         [x_offset, y_offset]
#       end

#       def offset_to_geometry(offset)
#         "-#{offset[0]}+700"
#       end

#       def resize_to_product_settings(image)
#         return image unless @settings.resolution

#         width, height = @settings.resolution.split('x').map(&:to_i)
#         image.resize("#{width}x#{height}")
#         image
#       end

#       def save_output(image)
#         output_path = generate_output_path
#         image.write(output_path)
#         Success(output_path)
#       end

#       def generate_output_path
#         Rails.root.join('temp', "#{self.class.name.demodulize.underscore}_#{@product.id}.#{@settings.output_extension}")
#       end
#     end
#   end
# end
module V1
  module Assets
    class OverlayAssets
      include Dry::Monads[:result, :do]
      include DryInteractions::InteractionErrors

      def load_image(path)
        MiniMagick::Image.open(path)
      end

      def overlay_image(base_image, overlay_image, offset, position: 'South')
        base_image.composite(overlay_image) do |c|
          c.compose 'Over'
          c.geometry(offset_to_geometry(offset)) if offset
          c.gravity position unless offset
        end
      end

      def calculate_offset(overlay, base)
        x_offset = (base.width - overlay.width) / 2
        y_offset = (base.height - overlay.height) / 2
        [x_offset, y_offset]
      end

      def offset_to_geometry(offset)
        "-#{offset[0]}+900"
      end

      def resize_to_product_settings(image)
        return image unless @settings.resolution

        width, height = @settings.resolution.split('x').map(&:to_i)
        image.resize("#{width}x#{height}")
        image
      end

      def prepare_watermark
        watermark = load_image(watermark_asset_path)
        watermark = remove_background(watermark)
        apply_transparency(watermark, 0.1) # @settings.watermark_opacity
        watermark
      end

      def apply_transparency(image, opacity)
        image.combine_options do |c|
          c.alpha 'set'
          c.channel 'A'
          c.evaluate 'multiply', opacity
        end
        image
      end

      def remove_background(image)
        image.format('png') do |c|
          c.fuzz '20%'
          c.transparent 'white'
        end
        image
      end

      def save_output(image)
        output_path = generate_output_path
        image.write(output_path)
        Success(output_path)
      end

      def generate_output_path
        Rails.root.join('temp', "#{self.class.name.demodulize.underscore}_#{@settings.product.id}.#{@settings.output_extension || 'jpg'}")
      end

      def watermark_asset_path
        @watermark_asset_path ||= @settings.product.watermark_asset&.image&.path
      end

      def watermark_position
        'Center'
      end
    end
  end
end
