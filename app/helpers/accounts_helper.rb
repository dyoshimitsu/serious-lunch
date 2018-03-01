# frozen_string_literal: true

module AccountsHelper

  def gravatar_for(account, size: 80)
    gravatar_id = Digest::MD5.hexdigest(account.email_address.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: account.account_name, class: 'gravatar')
  end
end
