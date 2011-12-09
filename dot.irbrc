IRB.conf.update(
  :SAVE_HISTORY => 10000,
  :PROMPT_MODE => :DEFAULT,
  :HISTORY_FILE => "#{ENV['HOME']}/.irb_history"
)

%w(irb/completion pp rubygems wirb hirb hirb-unicode).each do |l|
  begin
    require l
  rescue LoadError
    puts $!
  end
end

class Object
  def tapp
    tap { pp self }
  end
end

begin
  Wirb.start
  Hirb.enable
rescue
  puts $!
end
