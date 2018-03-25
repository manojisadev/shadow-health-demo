module ApplicationHelper

  def render_flash
    flash_array = []
    flash.each do |type, messages|
      if messages.is_a?(String)
        flash_array << render(partial: 'shared/flash',
                              locals: { :type => type, :message => messages })
      else
        messages.each do |m|
          flash_array << render(partial: 'shared/flash',
                                locals: { :type => type, :message => m }) unless m.blank?
        end
      end
    end
    flash_array.join('').html_safe
  end
end
