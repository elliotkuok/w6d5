# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  sex         :string(1)        not null
#  name        :string           not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Cat < ApplicationRecord
    include ActionView::Helpers::DateHelper
    COLORS = %w(red green orange)
    validates :birth_date, :color, :sex, :name, :description, presence: true
    validates :color, inclusion: {in: COLORS}
    validates :sex, inclusion: {in: %w(M F)}
    validate :birth_date_cannot_be_future

    def birth_date_cannot_be_future
        if birth_date && birth_date > Date.today
            errors.add(:birth_date, 'cannot be in future')
        end
    end

    def age
        # time_ago_in_words(Time.now - 15.hours) 
        Date.today - birth_date
        # Sun, 18 May 2008 14:30:44 EDT -04:00
    end
end
