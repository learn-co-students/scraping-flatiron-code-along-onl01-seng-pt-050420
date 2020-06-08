require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  attr_accessor :title, :schedule, :description

  def initialize()
  end

  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
  end
  
  def get_courses
    get_page.css("#course-grid")
  end

  def make_courses
    courses = get_courses.css("h2").map{|i| i.text}
    schedules = get_courses.css(".date").map{|i| i.text}
    descriptions = get_courses.css("p").map{|i| i.text}
    full_courses = []
    courses.each{|i| full_courses << {title: i}}
    schedules.each_with_index{|v, i| full_courses[i][:schedule] = v}
    descriptions.each_with_index{|v, i| full_courses[i][:description] = v}
    full_courses.each{|i| Course.new(i)}
    # binding.pry
  end
end



