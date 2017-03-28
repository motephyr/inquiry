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

	def online_status(user)
	  content_tag :span, user.nickname,
	              class: "user-#{user.id} online_status #{'online' if user.online?}"
	end

	def user_status(user)
		if user.online?
	  	content_tag :span, '上線中'
	  else
	  	content_tag :span, '離線'
	  end

	end

  def rasf(text)
    Rinku.auto_link(simple_format(text), :all, 'target="_blank"').html_safe
  end

end
