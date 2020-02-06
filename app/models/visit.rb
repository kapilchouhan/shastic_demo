class Visit < ApplicationRecord
  has_many :pageviews, :dependent => :destroy

  # validates :evid, format: {with: Regexp.new(/\A[A-z0-9]{8}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{4}-[A-z0-9]{12}\z/)}

  def self.save_visit_and_pageviews(json)
    json.each do |record|
      visit = find_or_create_by(
        evid: record["referrerName"],
        vendor_site_id: record["idSite"],
        vendor_visit_id: record["idVisit"],
        visit_ip: record["visitIp"],
        vendor_visitor_id: record["visitorId"]
      )

      next unless visit.valid?

      action_details = record["actionDetails"]
      action_details.each do |detail|
        visit.pageviews.where(url: detail["url"])
        .first_or_create(
          title: detail["pageTitle"],
          url: detail["url"],
          time_spent: detail["timeSpent"],
          timestamp: detail["timestamp"]
        )
      end
    end
  end
end
