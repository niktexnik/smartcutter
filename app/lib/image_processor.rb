class ImageProcessor
  PYTHON_SCRIPT_PATH = Rails.root.join('app/lib/process_image.py').to_s

  def self.process_image(input_path, output_path, format: 'png', width: nil, height: nil, process_type: 'crop_image')
    cmd = "python3 #{PYTHON_SCRIPT_PATH} #{input_path} #{output_path} #{process_type} #{format}"
    cmd += " #{width}" if width
    cmd += " #{height}" if height
    res = `#{cmd}`
    res.chomp!
  end
end
