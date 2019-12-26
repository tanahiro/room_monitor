require "dropbox_api"
require "logger"

secret_path = File.join(__dir__, "secret/dropbox")
secret = File.open(secret_path) {|f| f.read}

log_file = "/tmp/motion/push_to_dropbox.log"
logger = Logger.new(log_file, shift_age = 5)
logger.level = Logger::INFO

client = DropboxApi::Client.new(secret)

Dir.glob("/tmp/motion/*.{jpg,mkv}") do |file|
  file_name = File.basename(file)

  next if file_name == "lastsnap.jpg"

  logger.info(file_name)

  begin
    raw = IO.read(file)
    client.upload("/#{file_name}", raw)

    File.delete(file)
  rescue Exception => e
    logger.error(e.message)
  end
end

Dir.glob("/tmp/motion/*.log") do |file|
  file_name = File.basename(file)

  begin
    raw = IO.read(file)
    client.upload("/#{file_name}", raw, :mode => :overwrite)
  rescue Exception => e
    logger.error(e.message)
  end
end
