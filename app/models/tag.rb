class Tag < ApplicationRecord
  UPDATABLE_ATTRIBUTES = [:title, :slug, :content, :new_position, :parent_id, :tag_image]

  has_many :merchandises
  has_many :merchandise_rates

  def parent_id= parent_id
    if parent_id == "#"
      move_to_root
    else
      super parent_id
    end
  end

  def new_position= new_position
    if parent.blank?
      prev_node = root.siblings[new_position.to_i - 1]
      move_to_right_of prev_node
    else
      move_to_child_with_index parent, new_position.to_i
      parent.reload
    end
  end
end
