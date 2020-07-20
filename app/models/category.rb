class Category < ActiveRecord::Base
    has_many :videos

    validates :name, presence: true

    before_destroy :remove_category_from_videos

    private

    def remove_category_from_videos
        Video.where(category_id: id).update_all(category_id: nil)  
    end 
end
