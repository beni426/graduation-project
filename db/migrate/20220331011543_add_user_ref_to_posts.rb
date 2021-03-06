# frozen_string_literal: true

class AddUserRefToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :user, null: false, foreign_key: true
  end
end
