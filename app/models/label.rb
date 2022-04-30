# frozen_string_literal: true

class Label < ApplicationRecord
  has_many :labellings, dependent: :destroy
  has_many :posts, through: :labellings
end
