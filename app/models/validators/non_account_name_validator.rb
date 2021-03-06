# frozen_string_literal: true

class Validators::NonAccountNameValidator < ActiveModel::Validator
  NON_ACCOUNT_NAME = %w[
    about
    account
    account_activations
    accounts
    activity
    all
    announcements
    anywhere
    api_rules
    api_terms
    apirules
    apps
    auth
    badges
    blog
    business
    buttons
    contacts
    devices
    direct_messages
    download
    downloads
    edit_announcements
    faq
    favorites
    find_sources
    find_users
    followers
    following
    friend_request
    friendrequest
    friends
    goodies
    hello
    help
    home
    i
    im_account
    inbox
    invitations
    invite
    jobs
    list
    login
    logo
    logout
    lunch
    lunches
    me
    mentions
    messages
    mockview
    notifications
    nudge
    oauth
    password_resets
    phoenix_search
    positions
    privacy
    public_timeline
    replies
    root
    rules
    saved_searches
    search
    sent
    serious
    serious_lunch
    sessions
    settings
    share
    signup
    signin
    similar_to
    statistics
    terms
    tos
    translate
    trends
    update_discoverability
    users
    welcome
    who_to_follow
    widgets
    zendesk_auth
    media_signup
  ].freeze

  def validate(record)
    return unless NON_ACCOUNT_NAME.include?(record.account_name.downcase)

    record.errors[:base] << 'That name is reserved and can not be used'
  end
end
