class SendEmailNotificationJob < ApplicationJob
  queue_as :email_queue

  def perform(user, categories, time)
    category_list = []
    if time == 'monthly'
      message = "Hi #{user.givenname},\n\nThis month's category list made for you...\n"
    elsif time == 'weekly'
      message = "Hi #{user.givenname},\n\nThis week's category list made for you...\n"
    end
    categories.each do |category_id|
      category = ListingCategory.find(category_id)
      listings = Listing.where(listing_category: category)
      message += "\n\nListings available in #{category.name} are:\n\n"
      if listings.size > 0
        listings.each do |listing|
          message += "- #{listing.title} (£#{listing.price})\n"
        end
      else
        message += "There are no listings available in this category for now.\n\n"
      end
    end
    UserMailer.delay.message_email(user.email, "SU Marketplace Notification", message)
  end
end
