Paperclip.interpolates :hashed_path do |attachment, style|
  hash = Digest::MD5.hexdigest(attachment.instance.id.to_s + Micronemez::Application.config.upload_secret_token)
  hash_path = ''
  3.times { hash_path += '/' + hash.slice!(0..3) }
  hash_path[1..12]
end

Paperclip.interpolates :catnum do |attachment, style|
  attachment.instance.catnum
end