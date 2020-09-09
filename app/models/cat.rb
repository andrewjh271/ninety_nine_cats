# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birthdate   :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  COLORS = %w[black white tuxedo calico orange tortoiseshell]

  validates :birthdate, :color, :name, :sex, :description, presence: true
  validates :color, inclusion: { in: COLORS }, if: -> { color }
  validates :sex, length: { is: 1 }, if: -> { sex }
  validate :no_future_birthdate, if: -> { birthdate }

  has_many :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy

  def age
    time_ago_in_words(birthdate)
  end

  private

  def no_future_birthdate
    if birthdate > Date.today
      errors[:birthdate] << 'Cat\'s birthdate can\'t be in the future'
    end
  end
end
