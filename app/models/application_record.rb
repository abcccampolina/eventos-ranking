class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end



# Rails.logger.formatter = proc do | severity, time, progname, msg | 
#   File.open(File.join(Rails.root,'log', 'payload_dev.sql'), 'a') do |file|
#     file.write msg + "\n"
#   end if msg.match /CREATE|UPDATE/
#   "#{msg}\n"
# end

# ActiveRecord::Base.logger = Rails.logger

# class << connection
#   alias :original_exec :execute
#   def execute(sql, *name)
#     # try to log sql command but ignore any errors that occur in this block
#     # we log before executing, in case the execution raises an error
#     puts sql
#     begin
#         File.open(Rails.root.join("/log/sql.txt"),'a'){|f| f.puts Time.now.to_s+": "+sql}
#     rescue Exception => e
#       ;
#     end
#     # execute original statement
#     original_exec(sql, *name)
#   end
# end
