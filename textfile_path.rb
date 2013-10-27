class TextfilePath
  DEFAULT_LIBRARY_ROOT = File.join(File.dirname(__FILE__), 'library')

  def initialize(path, library_root=nil)
    @path = path
    @library_root = library_root || DEFAULT_LIBRARY_ROOT
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
    File.join(@library_root, *dest_letters)
  end

  def dest_filepath
    File.join(dest_dirname, basename)
  end

  def dest_clean
    dest_filepath.sub(/\.txt$/, '.clean')
  end
end