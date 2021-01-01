# require libraries/modules here
require "nokogiri"
require "pry"

def create_project_hash
  # write your code here
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri:: HTML(html)
  #set up a loop to iterate through the project(and also empty project hash, which we will fill up with scraped data)
  projects = {}

  #Iterate through the projects
  kickstarter.css("li.project.grid_4").each do |project|
    #make it so that each project title is a key
    #and the value is another hash with each of our other data points as keys
    ##to_sym method converts the title into a symbol
  
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("ul.project-meta span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end 

  # return the projects hash
  projects

  #binding pry
end

#create_project_hash

#selector
# projects:  kickstarter.css("li.project.grid_4") (add .first to see the first project)
# Title: project.css("h2.bbcard_name strong a").text => "Moby Dick: An Oratorio"
# image link: project.css("div.project-thumbnail a img").attribute("src").value
# description: project.css("p.bbcard_blurb").text
# location: project.css("ul.project-meta span.location-name").text => "Brooklyn, NY"
# funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i