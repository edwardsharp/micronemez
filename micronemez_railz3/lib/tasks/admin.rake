namespace :micronemez do

  namespace :admin do

    desc "Creates a role."
    task :create_role, [:role] => :environment do |t, args|

      unless args[:role]
        puts "You have to specify role name. Tip: 'rake micronemez:admin:create_role[admin]'"
        next
      end

      Role.create!(:name => args[:role])

    end


  end

end