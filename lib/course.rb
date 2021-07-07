class Course
  attr_accessor :title, :schedule, :description
  
  @@all = []
  
  def initialize
    save
  end
  
  def save
    @@all << self
  end
  
  def self.all
    @@all
  end
  
  def self.reset_all
    @@all.clear
  end
  
end