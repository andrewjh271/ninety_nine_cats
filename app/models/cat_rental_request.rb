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
#
class CatRentalRequest < ApplicationRecord
  belongs_to :cat

  validates :start_date, :end_date, presence: true
  validates :status, inclusion: { in: %w[APPROVED PENDING DENIED] }
  validate :start_before_end
  validate :does_not_overlap_approved_request

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

    ActiveRecord::Base.transaction do
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

  private

  def start_before_end
    return unless start_date && end_date

    unless start_date < end_date
      errors[:base] << 'Start date must come before end date'
    end
  end

  def does_not_overlap_approved_request
    return unless [cat_id, start_date, end_date].none?(nil)

    if overlapping_approved_requests.exists?
      errors[:base] << 'Dates conflict with an existing approved request'
    end
  end
end
