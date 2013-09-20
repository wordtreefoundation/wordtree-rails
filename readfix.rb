id_map = {}
$stdin.each_line do |line|
  id = line.chomp
  id_map[id] = true
end

Dir.glob("**/*.txt") do |file|
  id = File.basename(file).sub('.txt', '')
  if id_map[id]
  elsif id_map[id.sub('_djvu', '')]
    puts "mv #{file} #{File.join(File.dirname(file), id.sub('_djvu', '') + '.txt')}"
  else
    puts "mv #{file} ../library.misc/"
  end
end
