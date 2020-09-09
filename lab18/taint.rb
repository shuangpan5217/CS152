=begin
Update the Record class so that updates with either
a tainted name or a tainted value are ignored.
Do this first by explicitly checking the taint on a field.

Would this be sufficient if an attacker could control part of the code?
If not, how could the different taint modes be useful?
=end

class Record
  def initialize fields
    @fields = fields
  end

  def set_property name, value
    if(name.tainted? == false && value.tainted? == false)
    	@fields[name] = value
    end
  end
  def get_property name
    @fields[name]
  end
end

r = Record.new 'fname' => 'Rick', 'lname' => 'Grimes', 'profession' => 'Police Officer'
#$SAFE = 3
r.set_property 'profession'.taint, 'Zombie Hunter'
r.set_property 'lname', 'Smith'.taint

p r.get_property 'profession'
p r.get_property 'lname'

#This is not efficient since the safety level is not increased. we need to increase the safe level to 3 which 
#avoiding tainted data to be passed in or similar safety control

#$SAFE=2 to 4 are obsolete (ArgumentError) 