namespace :admin do
  task :promote, [:user, :needs] => :environment do |t, args|
    begin
      user = User.find(Integer(args[:user]))
    rescue ArgumentError
      user = User.where(:name => args[:user]).first
    end
    if user
      puts "Promoting #{user.name} to admin"
      user.promote!
    else
      puts "User #{args[:user]} not found"
    end
  end
end