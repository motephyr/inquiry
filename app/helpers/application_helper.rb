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
end
