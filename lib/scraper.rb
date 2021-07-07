require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'
#We are requiring our Course class file so that 
#our Scraper can make new courses and give them attributes scraped from the web page.

class Scraper
  
  def print_courses
    #calls on make courses
    self.make_courses
    #iterates over all courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    #responsible for usng Nokogiri to grab the HTML doc
    doc = Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    #gets us targetted elements
    # doc.css(".post").each do |post|
    #   course = Course.new
    #   course.title = post.css("h2").text
    #   course.schedule = post.css(".date").text
    #   course.description = post.css("p").text
    # end
  end

  def get_courses
    #responsible for using css selector to grab HTMl elements containing a course
    #returns a collection of elements
    self.get_page.css(".post")

  end

  def make_courses
    #responsible for instantiating course objects
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
    end
  end

  
end
Scraper.new.print_courses



