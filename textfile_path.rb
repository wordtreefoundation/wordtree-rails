class TextfilePath
  LIBRARY = File.join(File.dirname(__FILE__), '..', 'library')

  def initialize(path, library = LIBRARY)
    @path = path
    @library = library
  end

  def source
    @path
  end

  def basename
    File.basename(@path)
  end

  def dirname
    File.dirname(@path)
  end

  def dest_letters
    [basename[0], basename[1], basename[2]]
  end

  def dest_dirname
    File.join(@library, *dest_letters)
  end

  def dest_filepath
    File.join(dest_dirname, basename)
  end

  def dest_clean
    dest_filepath.sub(/\.txt$/, '.clean')
  end
end