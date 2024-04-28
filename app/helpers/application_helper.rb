module ApplicationHelper

  def admin?
    request.subdomain == 'admin'
  end

  def exhibitor?
    request.subdomain == 'exhibitor'
  end

  def front?
    request.subdomain.blank?
  end

  def icon(icon_name)
    tag.i(class: ["bi", "bi-#{icon_name}"])
  end

  def icon_with_text(icon_name, text)
    tag.span(icon(icon_name), class: "me-2") + tag.span(text)
  end

  def turbo_stream_flash
    turbo_stream.append "flashes", partial: "flash"
  end

  def url_with_params(url, params = {})
    uri = URI.parse(url)
    uri.query = URI.encode_www_form(params.to_a)
    uri.to_s
  end
end
