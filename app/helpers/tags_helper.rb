module TagsHelper

  def linked_tag_string(tags)

    if tags.count < 1
    	return 'none'
    end

    links = Array.new
    tags.each do |t|
      links << link_to( t.name, t )
    end

    links.join(", ")
  end
end
