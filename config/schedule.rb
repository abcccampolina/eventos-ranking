every 2.hours do
  rake "remittances:generate"
  command "java -jar /home/ubuntu/caixa/jclient/SMEDI-JClient.jar"
end


every 1.day, at: ['6:00 am', '6:30 am', '7:00 am', '7:30 am', '8:00 am', '8:30 am', '9:00 am', '9:30 am'] do
  rake "remittances:process_returns"
end