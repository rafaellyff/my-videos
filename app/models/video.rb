class Video < ActiveRecord::Base
    belongs_to :category
    has_many :comment

    validates :title, :youtube_url, :category_id, presence: true

    before_save do 
        if self.youtube_url.include?('.com') 
            self.youtube_embed_id = self.youtube_url.remove("https://www.youtube.com/watch?v=")
        else
           self.youtube_embed_id = self.youtube_url.remove("https://youtu.be/")
        end
    end
end
