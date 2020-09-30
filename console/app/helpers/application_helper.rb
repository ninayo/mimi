module ApplicationHelper

  def submenu(caption, qs_parameter_name, items)
    if (items || []).empty?
      { nil => nil }
    else
      caption = (items.select { |item| item[0].to_s==params[qs_parameter_name].to_s }.first.try(:[], 1) || caption)  if params[qs_parameter_name]
      { caption => items.map { |item| [item[1], request.path + '?' + request.query_parameters.merge(qs_parameter_name.to_sym => item[0]).to_query ] } }
    end
  end


  def current_url_as_json
    request.base_url + if request.original_fullpath=~/\?/
      request.original_fullpath.gsub(/\?/, '.json?')
    else
      request.original_fullpath + '.json'
    end
  end


  def current_user_cache_digest(name)
    # if current_user
    #   "#{name}#{current_user.updated_at.to_i}"
    # else
      name
    # end
  end

end
