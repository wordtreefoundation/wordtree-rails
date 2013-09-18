
def command(cmd)
  puts cmd
  `#{cmd}`
end

glob = '*'
round = 0
begin
  file = 1
  puts "Globbing #{glob}.freq"
  globbed = Dir.glob("#{glob}.freq")
  puts "globbed #{globbed.size} files"
  globbed.each_slice(6) do |fs|
    c = (round + 'a'.ord).chr + file.to_s + '.freq'
    if fs.size < 6
      for f in fs
        dest = (round + 'a'.ord).chr + file.to_s + '.freq' 
        file += 1
        command "cp #{f} #{dest}"
      end
    else
      file += 1
      command "../../sum #{fs.join(' ')} >#{c}"
    end
  end
  glob = (round + 'a'.ord).chr + '*'
  round += 1
end while file > 1
