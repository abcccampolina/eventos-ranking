class String
  def rgb(r, g, b)
    "\x1b[38;2;#{r};#{g};#{b}m#{self}\x1b[0m"
  end
end

Shog.configure do
  if ::Rails.env.production?
    reset_config!
    timestamp
  end

  # severity(:info){ |msg| msg.rgb(40,177,249) }
  severity(:info){ |msg| msg.rgb(140,147,229) }
  severity(:fatal){ |msg| msg.red.on_black }

  match /Registered connection/ do |msg,matches|
    # Highlight timeout errors
    a = msg.scan(/(?<=\()\w+(?=\)$)/).first # Z2lkOi8vc2d2L1VzZXIvMQ
    b = msg.gsub(/[(){}\[\]]/) {|i| i.yellow }
    b[a] = a.green.bold
    b[matches] = matches.light_black
    b
  end
  
 
  match /Parameters:/ do |msg,matches|
    # Highlight timeout errors
    # 255, 204, 20 # amarelo
    # 139, 151, 152 # aspas
    # "Parameters: " << Pygments.highlight(msg.split("Parameters: ").last, :formatter => 'terminal', :lexer => 'javascript', :options => {:encoding => 'utf-8'})
    
    "Parameters: " << Pygments.highlight(JSON.pretty_generate(JSON.parse(msg.gsub('=>', ':').split("Parameters: ").last)), :formatter => 'terminal', :lexer => 'javascript', :options => {:encoding => 'utf-8'})
    .gsub("{", "{".rgb(204, 255, 20))
    .gsub("}", "}".rgb(204, 255, 20))
    .gsub("=>", "=>".rgb(204, 255, 20))
    .gsub(",", ",".rgb(139, 151, 152))
    # .gsub("\n", "\n[INFO ] [Parameters] ")
    
    # .gsub('"', '"'.rgb(139, 151, 152))
    # a = msg.scan(/(?<=\()\w+(?=\)$)/).first # Z2lkOi8vc2d2L1VzZXIvMQ
    # b = msg.gsub(/[(){}\[\]]/) {|i| i.yellow }
    # b[a] = a.green.bold
    # b[matches] = matches.light_black
    # b
  end

  # Dim detailed info about rendering views
  match /\s*Rendered\s+(?<view>[^\s]+)\s(within\s(?<layout>[^\s]+)\s)?\((?<time>.*)\)/ do |msg,match|
    # http://refiddle.com/18qr
    parts = ["  #{"Rendered".cyan} #{ match["view"].light_black.underline.bold }" ]
    parts << "within ".light_red + match["layout"].black.underline.bold if match['layout']
    parts << format_time( match['time'].rgb(200,177,249), 50 )
    parts.join " "
  end

  match /\s*Rendering\s+(?<view>[^\s]+)\s(within\s(?<layout>[^\s]+)\s)*/ do |msg,match|
    # http://refiddle.com/18qr
    parts = ["  #{"Rendering".rgb(177,249,40)} #{ match["view"].light_black.bold }" ]
    parts << "within".light_red + msg.split("within").last.black.bold# if match['layout']
    # parts << format_time( match['time'].yellow, 50 )
    parts.join " "
  end
end