class HomeController < ApplicationController

	def index
	end

	def links_check
		begin 
			agent = Mechanize.new
    	result = agent.get(params[:link])
    	domain = get_domain(params[:link])
			links = ""
    	result.links.each do |link|
    		link = link.href
    		if link != "#" || link != "javascript:void(0)"
    			unless link.include?("http://") || link.include?("https://") 
    				link = "#{domain}/#{link}"
    			end	
	    			links += "<p> #{link} : "
	    			links += "#{page_links(link)}</p>"
    		end	
    	end	
    	return render text: links
    rescue Exception => e
    	return render text: e
    end	
	end	

	private

	def page_links(link)
		begin 
			agent = Mechanize.new
	    result = agent.get(link)
	    "<span style='color:green;'>Working<span>"
	  rescue Exception => e
	  	"<span style='color:red;'>#{e.to_s}<span>"  
	  end	
	end	

	def get_domain(link)
	  protocol = params[:link].split("://").first + "://"
		domain_name = URI.parse(params[:link]).host.downcase 
		protocol + domain_name
	end	
end
