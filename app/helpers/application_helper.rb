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

  def render_resolve_url(work)
    url = work.attach_url
    if (image_match = /\.(jpg|jpeg|tiff|png|gif|bmp)$/.match(url)) and image_match.present?
      # image matches
      content_tag :img, '', src: "#{url}"
    elsif (audio_match = /\.(wav|mp3|wma|midi|aif|aifc|aiff|au|ea)$/.match(url)) and audio_match.present?
      # audio matches
      content_tag :audio, '', controls: "controls", src: "#{url}", style: "width:100%;"
    elsif (video_match = /\.(mp4|webm|ogg)$/.match(url)) and video_match.present?
      # video matches
      content_tag :video, '', controls: "controls", src: "#{url}", width: "100%", height: "100%"
    elsif (youtube_match = /^(?:https?:\/\/)?(?:m\.|www\.)?(?:youtu\.be\/|youtube\.com\/(?:embed\/|v\/|watch\?v=|watch\?.+&v=))((\w|-){11})(\S*)?$/.match(url)) and youtube_match.present?
      # youtube matches
      content_tag :iframe, '', src: "https://www.youtube.com/embed/#{youtube_match[1]}?rel=0", width: '100%', height:'100%', frameborder: '0'
    else
      # others
      content_tag :div, :data => { :remote_url => url }, class: "remote-preview" do
        content_tag(:div,'', style: 'background-image:url(' + work.remote_image_url + ')', class: 'preview-image')  +
          content_tag(:p, work.remote_description,  class: 'preview-description')
      end
    end
  end

  def render_avatar_file(file)
    image_match = /\.(jpg|jpeg|tiff|png|gif|bmp)$/.match(file)
    audio_match = /\.(wav|mp3|wma|ogg|midi|aif|aifc|aiff|au|ea)$/.match(file)
    if image_match.present?
      content_tag :img, '', src: "#{file}"
    elsif audio_match.present?
      content_tag :audio, '', controls: "controls", src: "#{file}"
    end
  end

  def render_with_p_tags(str)
    str.gsub!(/\r\n?/, "\n")
    lines = str.split("\n")
    lines.collect {|line| concat(content_tag(:p, line.presence || "&nbsp;".html_safe))}
    ""
  end

  def rasf(text)
    Rinku.auto_link(simple_format(text), :all, 'target="_blank"').html_safe
  end

  def work_square(w)
    if w.attach_avatar.present?
      render_avatar_file(w.attach_avatar.url)
    elsif w.attach_url.present?
      render_resolve_url(w)
    elsif w.attach_content.present?
      sanitize w.attach_content
    else
    end
  end

  def ckeditor_content(user)
    if user.user_info.category.title == '工業設計'
      "製作​​​​​​​時間： \n\n準備素材： \n\n使用工具：                \n\n參考文件或連結：\n\n"
    elsif user.user_info.category.title == '美術設計'
      "製作​​​​​​​時間： \n\n內容簡介： \n\n                        \n\n參考文件或連結：\n\n"
    elsif user.user_info.category.title == '文字編輯'
      "製作​​​​​​​時間： \n\n概念發想： \n\n                        \n\n參考文件或連結：\n\n"
    elsif user.user_info.category.title == '程式開發'
      "製作​​​​​​​時間： \n\n功能簡介： \n\n使用的language和library： \n\n參考文件或連結：\n\n"
    elsif user.user_info.category.title == '行銷企畫'
      "製作​​​​​​​時間： \n\n概念發想： \n\n                        \n\n參考文件或連結：\n\n"
    elsif user.user_info.category.title == '音樂人'
      "製作​​​​​​​時間： \n\n準備素材： \n\n使用工具：                \n\n參考文件或連結：\n\n"
    elsif user.user_info.category.title == '影像製作'
      "製作​​​​​​​時間： \n\n準備素材： \n\n使用工具：                \n\n參考文件或連結：\n\n"
    elsif user.user_info.category.title == '財務會計'
      "描述你的工作成果..."
    elsif user.user_info.category.title == '其他'
      "描述你的工作成果..."
    end

  end
end
