class PushNotification
  def self.client
    @client ||= HTTPClient.new
  end

  def initialize(registration_id, alert)
    @registration_id = registration_id
    @alert = alert
  end

  def deliver
    self.class.client.post("https://android.googleapis.com/gcm/send", to_json, {
      "Authorization" => "key=AIzaSyCABSTd47XeIH",
      "Content-Type" => "application/json"
    })
  end

  def to_json
    {
      "registration_ids" => [@registration_id],
      "data" => {
        "alert" => @alert
      }
    }.to_json
  end
end
