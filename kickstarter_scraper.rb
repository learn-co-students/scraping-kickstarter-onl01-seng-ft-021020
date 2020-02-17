# require libraries/modules here
require 'pry'
require 'nokogiri'

# :projects => {
#   "My Great Project"  => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   },
#   "Another Great Project" => {
#     :image_link => "Image Link",
#     :description => "Description",
#     :location => "Location",
#     :percent_funded => "Percent Funded"
#   }
# }

def create_project_hash
  
  html = File.read("./fixtures/kickstarter.html")
  kickstarter = Nokogiri::HTML(html).css(".project-card")
  projects = Hash.new({})
  kickstarter.each do |project|
    projects[project.css(".bbcard_name strong a").text.strip.to_sym] = {
      image_link: project.css(".project-thumbnail a img").attribute("src").value.strip,
      description: project.css(".bbcard_blurb").text.strip,
      location: project.css(".project-meta .location-name").text.strip,
      percent_funded: project.css(".project-stats .first strong").text.strip.gsub("%", "").to_i,
    }
    
  end
  projects

end