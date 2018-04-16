# coding: utf-8
# ref. http://motty.blog.jp/archives/51470861.html
#
# example:
# $ ruby scaffold.rb table_name
#

table_name = ARGV[0]

script = <<-END
columns = ActiveRecord::Base.connection.columns("#{table_name}").map{|c| "\#{c.name}:\#{c.type}" }.join(" ")
cmd = "bundle exec rails g scaffold #{table_name} \#{columns} --skip-migration"
p cmd
system(cmd)
END

system("bundle exec rails runner '#{script}'")
