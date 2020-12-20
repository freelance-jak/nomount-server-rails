class PresentationUploader < BaseUploader
  def store_dir
    # TODO presentationのmember_idが実装されたらパスを変更
    "uploads/presentations/#{model.id}"
  end

end
