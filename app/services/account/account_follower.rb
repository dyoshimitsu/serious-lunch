# frozen_string_literal: true

class Account::AccountFollower
  include Virtus.model

  attribute :account, Account, reader: :private

  def follow(other_account)
    account.active_account_relationships.create(
      followed_account_id: other_account.account_id
    )
  end

  def unfollow(other_account)
    account.active_account_relationships.find_by(
      followed_account_id: other_account.account_id
    ).destroy
  end

  def following?(other_account)
    account.following.include?(other_account)
  end
end
