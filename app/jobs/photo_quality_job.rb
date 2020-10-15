class PhotoQualityJob < ApplicationJob
  queue_as :default

  def perform(photo_id)
    photo = Photo.find(photo_id)
    #f = IO.popen("python3 example.py #{photo.url}")
    f = IO.popen("python3 image_pro.py \"#{photo.url}\"")
    result = f.readlines[0].chomp.downcase
    f.close
    accepted = result.split(" ")
    photo.update_attributes(accepted_lum: accepted[0],
                            accepted_foc: accepted[1])
  end

end
