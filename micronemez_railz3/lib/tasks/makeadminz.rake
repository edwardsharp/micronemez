namespace :micronemez do

  namespace :admin do

    desc "make adminz."
    task :make_admin, [:user] => :environment do |t, args|

      unless args[:user]
        puts "You have to specify user name. Tip: 'rake micronemez:admin:make_admin[edward]'"
        next
      end

        u=User.find_by_username(args[:user])
        u.make_admin
    end


  end

end