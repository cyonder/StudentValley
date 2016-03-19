module ApplicationHelper

  # ---------------------------------------------------------------------------- #
  # -- title ------------------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #
  # This method is used for setting up titles for pages. If this method is not
  # used on a page, the default title 'Student Valley' will be set automatically.
  # ---------------------------------------------------------------------------- #

  def title(page_title)
    content_for(:title){ page_title }
  end

  # ---------------------------------------------------------------------------- #
  # -- current_path? ----------------------------------------------------------- #
  # ---------------------------------------------------------------------------- #
  # This method returns true if any match the user's current path. This can be
  # used as an alternative method to 'current_page?' method since it does not
  # support post method.
  # ---------------------------------------------------------------------------- #

  def current_path?(*paths)
    return true if paths.include?(request.path)
    false
  end

  def active_link_to(options = nil, html_options = nil, &block)
    active_class = html_options[:active] || 'selected'
    html_options.delete(:active)
    html_options[:class] = "#{html_options[:class]} #{active_class}" if request.env['PATH_INFO'] == options
    link_to(options, html_options, &block)
  end
end
