$:.unshift(File.join(File.dirname(__FILE__), '..'))

def fixture(file)
  File.join(File.dirname(__FILE__), 'fixtures', file)
end