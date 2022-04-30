# frozen_string_literal: true

class Labelling < ApplicationRecord
  belongs_to :post
  belongs_to :label
end
