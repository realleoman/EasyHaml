require 'fileutils'
#require 'haml'
view_path = File.join(RAILS_ROOT, 'app', 'views')

namespace :easyhaml do

    
    desc "Converts HTML to HAML"  
    task :convert => :environment do
      proceed = true
      if File.directory?(view_path)
          puts "\n\n.This process will convert the .html.erb files to .haml. "
          loop do
            print "¿Are you sure? [yes/no]: "
            proceed = STDIN.gets.strip
            break unless proceed.blank?
          end
          proceed = (proceed =~ /y(?:es)*/i)

         if proceed 
         @files = Dir.glob("#{view_path}/**/*.html.erb")
         current_dir = nil
          for file in @files
            if current_dir != File.dirname(file)
              puts "\nCurrent directory is #{File.dirname(file)}: \n"              
            end
            current_dir = File.dirname(file)
            if File.extname(file) == ".erb"
              `html2haml -rx #{file} #{file.gsub(/\.erb$/, '.haml')}`
              puts "The file #{File.basename(file)} has been converted succesfully."
             end
          end
         end    

      else
        puts "The #{view_path} directory does not exist"
      end     
    end

    desc "Deletes HAML files within views folders"
    task :deletehaml => :environment do
      proceed = true
      if File.directory?(view_path)
         puts "\n\nThe .haml files will be deleted "
         loop do
           print "¿Are you sure? [yes/no]: "
           proceed = STDIN.gets.strip
           break unless proceed.blank?
         end
         proceed = (proceed =~ /y(?:es)*/i)

        
         if proceed 
         @files = Dir.glob("#{view_path}/**/*.haml")
         current_dir = nil
          for file in @files
            if current_dir != File.dirname(file)
              puts "\nCurrent directory is #{File.dirname(file)}: \n"              
            end
            current_dir = File.dirname(file)
            if File.extname(file) == ".haml"
              FileUtils.rm(file)
              puts "The file #{File.basename(file)} has been deleted succesfully."
             end
          end
         end         
        
        
      else
        puts "The #{view_path} directory does not exist"
      end
    end

end