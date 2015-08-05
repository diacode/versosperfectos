# Clase que permite la subida de ficheros a través de AJAX
class AppSpecificStringIO < StringIO
  attr_accessor :filepath

  def initialize(*args)
    super(*args[1..-1])
    @filepath = args[0]
  end

  def original_filename
    File.basename(filepath)
  end
end