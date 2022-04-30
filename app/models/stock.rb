# frozen_string_literal: true

class Stock < ApplicationRecord
  belongs_to :user
  belongs_to :post
end
