# == Schema Information
#
# Table name: volunteers
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  tel           :string(255)
#  commun        :string(255)
#  neighborhood  :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  subscriber_id :integer
#

class Volunteer < ActiveRecord::Base
  belongs_to :subscriber
  validates :name, :tel, :commun, :neighborhood, presence: true

  def self.export
    p = Axlsx::Package.new
    p.workbook.add_worksheet(:name => "志愿者") do |sheet|
      sheet.add_row ["姓名", "电话", "居委会", "小区"]

      Volunteer.all.each do |volunteer|
        sheet.add_row [volunteer.name, volunteer.tel, volunteer.neighborhood, volunteer.commun]
      end
      p.use_shared_strings = true
      p.serialize("public/volunteer.xlsx")
    end
  end

end
