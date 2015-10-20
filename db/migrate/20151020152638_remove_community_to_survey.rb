class RemoveCommunityToSurvey < ActiveRecord::Migration
  def change
    remove_reference :surveys, :community, index: true
  end
end
