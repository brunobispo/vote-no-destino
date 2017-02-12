# == Schema Information
#
# Table name: choices
#
#  id         :integer          not null, primary key
#  chosen_id  :integer
#  answer_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Choice, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
