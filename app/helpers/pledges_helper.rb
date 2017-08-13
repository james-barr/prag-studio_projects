module PledgesHelper

  def time_since(pledge)
    time_ago_in_words pledge.created_at
  end

end
