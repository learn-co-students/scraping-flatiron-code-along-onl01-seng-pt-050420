class Course
  attr_accessor:title,:schedule,:description
  @@all = []
  
    @@all << self
  def initialize
  end
  
  def self.all
    @@all
  end
  
  def self.reset_all
    @@all.clear
  end
end

