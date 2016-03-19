module HomeHelper
  # Returns the width of body class.
  def body_width
    if  current_page?(root_path) ||
        current_page?(about_path) ||
        current_page?(contact_path) ||
        current_page?(faq_path) ||
        current_page?(terms_path) ||
        current_page?(privacy_path)
      'width: 980px'
    else
      'width: 464px'
    end
  end
end
