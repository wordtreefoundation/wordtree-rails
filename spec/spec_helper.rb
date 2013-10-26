$:.unshift(File.join(File.dirname(__FILE__), '..'))

def fixture(file)
  File.join(File.dirname(__FILE__), 'fixtures', file)
end

def tmp(file)
  FileUtils.mkdir_p(File.join(File.dirname(__FILE__), 'tmp'))
  File.join(File.dirname(__FILE__), 'tmp', file)
end