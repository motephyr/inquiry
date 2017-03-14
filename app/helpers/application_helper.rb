module ApplicationHelper
	def notice_message
		flash_messages = []
		flash.each do |type, message|
			type = "success" if type == "notice"
      type = "warning" if type == "alert"
      type = "danger" if type == "error"
			text = content_tag(:div, link_to("x", "#", :class => "close", "data-dismiss" => "alert", :onclick => "document.getElementById('close').style.display='none'") + message, :id => "close", :class => "alert fade in alert-#{type}")
			flash_messages << text if message
		end
		flash_messages.join("\n").html_safe
	end

	def category_cloud
		@categories = Category.includes(:subcategories).where("id < ?", 100)

		content = @categories.reduce('') do |all, c|
			all + "<tr><td width='20%'>#{c.title} #{c.id}</td>" +
			"<td width='80%'>" +
			c.subcategories.reduce('') do |sum, sub_category|
				sum + "#{sub_category.title} #{sub_category.id} "
		 	end +
		 	"</td></tr>"
		end

		"<table class='table table-bordered'>" + content + "</table>"
	end
end
