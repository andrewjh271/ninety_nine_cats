# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          default(-1), not null
#
class CatRentalRequest < ApplicationRecord
  include ActionView::Helpers::DateHelper

  belongs_to :cat
  belongs_to :requester,
    class_name: :User,
    foreign_key: :user_id

  validates :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w[APPROVED PENDING DENIED] }, if: -> { status }
  validate :start_before_end, if: -> { start_date && end_date }
  validate :starts_in_the_future, if: -> { start_date && end_date }
  validate :does_not_overlap_approved_request, if: -> { start_date && end_date }
  validate :cannot_rent_your_own_cat, if: -> { cat_id && user_id }

  def overlapping_requests
    CatRentalRequest.where(cat_id: cat_id)
                    .where.not('? > end_date OR ? < start_date', start_date, end_date)
                    .where.not(id: id)
  end

  def overlapping_approved_requests
    overlapping_requests.where(status: 'APPROVED')
  end

  def overlapping_pending_requests
    overlapping_requests.where(status: 'PENDING')
  end

  def approve!
    return false unless status == 'PENDING'

    transaction do
      overlapping_pending_requests.each(&:deny!)
      update(status: 'APPROVED')
    end
  end

  def deny!
    update(status: 'DENIED')
  end

  def pending?
    status == 'PENDING'
  end

  def cat_name
    cat.name
  end

  def cat_owner
    cat.owner
  end

  def cat_requester
    requester.username
  end

  private

  def start_before_end
    unless start_date < end_date
      errors[:base] << 'Start date must come before end date'
    end
  end

  def does_not_overlap_approved_request
    if overlapping_approved_requests.exists?
      errors[:base] << 'Dates conflict with an existing approved request'
    end
  end

  def cannot_rent_your_own_cat
    if cat.owner == requester
      errors[:user_id] << 'Owner cannot rent their own cat!'
    end
  end

  def starts_in_the_future
    if start_date < Date.today
      errors[:start_date] << 'Start date must be in the future'
    end
  end
end
