require 'rails_helper'

describe 'End to end test' do


  specify 'I cannot access the blog without logging in' do
    visit '/'
    expect(page).to have_content 'Sheffield University Marketplace'
    expect(page).to have_content 'COVID 19 guidences'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
  
  context 'As a logged in user' do
    

    before do
      user = FactoryBot.create(:user. id: 1)
      admin = FactoryBot.create(:user, administrator: true)
      @condition_new = ListingCondition.create(name: "New")
      @condition_used = ListingCondition.create(name: "Used")
      @category_electronics = ListingCategory.create(name: "Electronics")
      @category_cloting = ListingCategory.create(name: "Cloting")
      @category_books = ListingCategory.create(name: "Books")
      @public_post  = Listing.create(title: 'A title for a post',        description: 'Some public content')
      @private_post = Listing.create(title: 'A title for a secret post', description: 'Some private content')
      @iphone_post = Listing.create(title: 'Iphone', listing_condition: @condition_used, price: 500, listing_category: @category_electronics )
      @airpods_post = Listing.create(title: 'Airpods', Listing_condition: @condition_used, price: 200, Listing_category: @category_electronics)
      @status_pending = ListingStatus.create(id: 1, name: "Pending")
      @status_complete = ListingStatus.create(id: 2, name: "Complete")
      @sold_post = Listing.create(title: 'a sold listing', receiver_id: 1, listing_status_id: 2)
      @sold_out_post = Listing.create(title: 'a sold listing by me', creator_id: 1, listing_status_id: 2)
      login_as(user, scope: :user)
    end
    def create_new_listing 
      # condition_new = FactoryBot.create :listing_condition, name: 'New'
      # condition_new = ListingCondition.create(name: "New")
      # category_books = ListingCategory.create(name: "Books")
      # category_books = FactoryBot.create :listing_category, name: 'Books'
      # tag_education = Tag.create(name: "Education")
      visit '/'
      click_link 'Create Listing'
      fill_in 'Title', with: 'My Title'
      fill_in 'Price', with: '123'
      fill_in 'Description', with: 'My description'
      select 'New', from: 'Condition'
      select 'Books', from: 'Category'
      check 'Collection'
      fill_in 'Location', with: 'My Location'
      # # fill_in 'Tags', with: 'Education'
      # # select 'Education', from: 'Tags'
      # # select2("Education", from: "Tags")
      click_button 'Create Listing'
    end


    # Home page 
    specify "I can find this new listing in my listing page" do

      create_new_listing
      click_link "My Listings"
      expect(page).to have_content 'My Title'
      
    end

    specify "I can click 'Edit' button on that listing" do 
      
      create_new_listing
      click_link "My Listings"
      click_button "Edit"
      expect(page).to have_content "My Title" """it is javesript so """
    end 

    specify "I can click 'See Details' " do 
      create_new_listing
      click_link "My Listings"
      click_button "See Details"
      expect(page).to have_content "My Title"
    end 

    specify "I can delete my listing" do 
      create_new_listing
      click_link "My Listings"
      click_button "Delete"
      expect(page).to not_to have_content 'My Title'
    end

    # Message page
    specify "I can see my conversations with different users" do 
    
    end 

    specify "I can check out all my favourite listings " do
      
      visit '/'
      click_link "heart-link"
      click_link "Favourate"
      expect(page).to have_content 'User2 listing'

    end 
    specify "check the reviews" do
      visit '/'
      click_link "Reviews"
      expect(page).to have_content "Leave a Review"
      expect(page).to have_content "My Reviews"
    end 

    specify "I can checkout my setting page and choose when to got email notifications " do 
      visit '/'
      click_link "Settings"
      check "When I receive a message"
      select "All" from "When an item from this category is posted"
      radio_check "Weekly" from "When?"
      click_button "Save"
      expect(page).to have_content "succussful?"
    end 
    specify "I could create a new listing" do
      create_new_listing
      expect(page).to have_content 'Listing was successfully created.'
    end

    specify "Swapping Items" do 
      visit '/'
      click_button "Open to swap"
    end 

    specify "I can editing my listings" do 
      visit '/'
      click_button "My Listings"
      click_button "Edit"
      #click x to delete current image
      #upload images
      fill_in "Title", with: "My New Title"
      fill_in 'Price', with: '321'
      fill_in 'Description', with: 'My new description'
      select 'Used', from: 'Condition'
      select 'Cloting', from: 'Category'
      uncheck 'Collection'
      check "Postage"
      fill_in 'New Location', with: 'My Location'
      # # fill_in 'Tags', with: 'Education'
      # # select 'Education', from: 'Tags'
      # # select2("Education", from: "Tags")
      click_button 'Update Listing'
      expect(page).to have_content "My New Title"
      expect(page).to have_content "My new description"
      expect(page).to have_content "£ 321"
    end



    specify "Search listing by inputing keyword " do
      visit '/'
      fill_in "Search Bar", with "A title for a post"
      click_button "Confirm"
      expect(page).to have_content "A title for a post"
      visit '/'
      select2("Education", from: "Select Tags")
      click_button "Confirm"
      expect(page).to have_content "Book"
    end

    specify "I can sort listings by different options" do
      visit '/'
      click_button "Sort By Title"
      click_button "Sort By Price"
      click_button "Sort by Date Created"
      # could be done by unit test
    end

    specify "I can filter through items by different options" do
      visit '/'
      select 'Electronics', from: 'Categories'
      fill_in "Max Price", with "200"
      select 'Used', from: 'Condition'
      check "Collection"
      check 'Drop-off'
      check 'Postage'
      click_button 'Confirm'
      expect(page).to have_content "Airpods"
      expect(page).not_to have_content "Iphone"
    end
    specify "I can view COVID-19 guidance in website" do
      visit '/'
      expect(page).to have_content "COVID-19 Guidance"
    end

    specify "As a buyer, I can review a seller I have purchased an item from " do
      visit '/'
      click_link "Reviews"
      expect(page).to have_content "a sold listing"
      click_button "Review"
    end

    specify "As a seller, I can review a buyer who has purchased an item from me" do
      visit '/'
      click_link "Reviews"
      expect(page).to have_content "a sold listing by me"
      click_button "Review"

  end

  specify "I can check FAQ page" do
    visit '/'
    click_link "FAQ"
    expect(page).to have_content "Frequently Asked Questions"
    expect(page).to have_current_path('/faq')
  end

  specify "I can check About page" do
    visit '/'
    click_link "About"
    expect(page).to have_content "About this site"
    expect(page).to have_current_path('/about')
  end

  specify "I can check Contact page" do
    visit '/'
    click_link "Contact"
    expect(page).to have_content "Get in touch"
    expect(page).to have_current_path('/contact')
  end

  specify "I can add a listing to my favourite listings " do
    # https://stackoverflow.com/questions/51457862/capybara-click-button-with-no-text-or-id
    visit '/'
    find('a.heart-link').click
    visit '/profile/user_favourites'
    # https://stackoverflow.com/questions/12851932/rails-capybara-how-to-click-a-link-in-a-table-row-that-also-contains-unique-tex
    # https://stackoverflow.com/questions/37405002/capybara-ambiguous-matching-link-or-button-nil
    # https://stackoverflow.com/questions/37405002/capybara-ambiguous-matching-link-or-button-nil


  end

  specify "I can add and delete ban words " do


  context 'As a logged in admin' do
    before do

      admin = FactoryBot.create(:user, administrator: true)
      user = FactoryBot.create(:user, administrator: false, username: "username", email: "username@sheffield.ac.uk")
      @condition_new = ListingCondition.create(name: "New")
      @condition_used = ListingCondition.create(name: "Used")
      @category_electronics = ListingCategory.create(name: "Electronics")
      @category_cloting = ListingCategory.create(name: "Cloting")
      @category_books = ListingCategory.create(name: "Books")
      @public_post  = Listing.create(title: 'A title for a post',        description: 'Some public content')
      @private_post = Listing.create(title: 'A title for a secret post', description: 'Some private content')
      @iphone_post = Listing.create(title: 'Iphone', listing_condition: @condition_used, price: 500, listing_category: @category_electronics )
      @airpods_post = Listing.create(title: 'Airpods', Listing_condition: @condition_used, price: 200, Listing_category: @category_electronics)
      @status_pending = ListingStatus.create(id: 1, name: "Pending")
      @status_complete = ListingStatus.create(id: 2, name: "Complete")
      @pending_post = Listing.create(title: 'A pending listing', listing_status_id: 1)
      @pending_approve_posy = Listing.create(title: 'A pending listing need to approve', listing_status_id: 1)
      login_as(admin, scope: :user)
    end
    specify "I can promote and demote other users as admin " do

      visit "/"
      click_link "Other"
      click_button "Add a new admin"
      fill_in "Username", with: "username"
      fill_in "Email", with: "username@sheffield.ac.uk"
      click_button "Add a admin"
      expect(page).to have_content "username"
      # within_fieldset('Admin permissions') do
      #   click_button "Remove"
      # end
      find(:xpath, "//tr[td[contains(.,'username')]]/td/a", :text => 'Remove').click
      expect(page).not_to have_content "username@sheffield.ac.uk" 
    end
    specify "I can moderate new postings before they are released" do
      visit '/'
      click_link "Moderation"
      expect(page).to have_content "A pending listing"
      # need approve case here
      # click_button "See Details"
      click_button "Delete"
      expect(page).not_to have_content "A pending listing"
    end

    specify "I can send emails notifications to all users" do
      visit '/'
      click_link "Other"
      fill_in "Send an email...", with: "Everyone should follow COVID-19 guidance"
      click_button "Send"
      expect(page).to have_content "The announcement has been sent to all user."
    end

    specify "I can view statistics pertaining to the usage of the website" do
      visit '/'
      click_link "Statistics"
      expect(page).to have_content "Site Traffic"
      expect(page).to have_content "Items sold"
      expect(page).to have_content "Items swapped"
      expect(page).to have_content "Overall item value sold"
      expect(page).to have_content "Top Categories"
    end
    # @javascript
    specify "I can add or remove questions and answers in FAQ page" do
      visit '/'
      click_link "Other"
      click_button "Add a new question"
      fill_in "Question", with: "Hello, I have a question."
      fill_in "Answer", with: "Hello, I have an answer."
      click_button "Add question"
      visit '/faq'
      expect(page).to have_content "Hello, I have a question."
      expect(page).to have_content "Hello, I have an answer."
      visit '/admin/other'
      within_fieldset('FAQs') do
        click_button "Remove"
      end
      expect(page).not_to have_content "Hello, I have a question."
    end



end
