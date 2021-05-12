require 'rails_helper'

describe 'End to end test' do


  # specify 'I cannot access the blog without logging in' do
  #   visit '/'
  #   expect(page).to have_content 'Sheffield University Marketplace'
  #   # expect(page).to have_content 'COVID 19 guidences'
  #   # expect(page).to have_content 'You need to sign in or sign up before continuing.'
  # end
  
  context 'As a logged in user' do
    

    before do
      user = FactoryBot.create(:user,  email: "user@sheffied.ac.uk", username:"user", uid: "user", mail: "user@sheffied.ac.uk", ou: "COM", dn: "uid=user,ou=Undergraduates,ou=Students,ou=Users,dc=sheffield,dc=ac,dc=uk", sn: "lastname", givenname: "givenname", administrator: false, is_banned: false, ban_reason: nil)
      @admin = FactoryBot.create(:user, administrator: true)
      # @condition_new = ListingCondition.create(name: "New")
      # @condition_used = ListingCondition.create(name: "Used")
      # @category_electronics = ListingCategory.create(name: "Electronics")
      # @category_cloting = ListingCategory.create(name: "Cloting")
      # @category_something = ListingCategory.create(id: 88,name: "Something else")

      @iphone_post = Listing.create(title: 'Iphone', listing_condition_id: 2, price: 500, listing_category_id: 3, listing_status_id: 2 )
      @airpods_post = Listing.create(title: 'Airpods', listing_condition_id: 2, price: 200, listing_category_id: 3)
      # @status_pending = ListingStatus.create(id: 1, name: "Pending")
      # @status_complete = ListingStatus.create(id: 2, name: "Complete")
      @sold_post = Listing.create(title: 'a sold listing', receiver_id: 100, listing_status_id: 2)
      @sold_out_post = Listing.create(title: 'a sold listing by me', creator_id: 100, listing_status_id: 2)
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
      attach_file('Upload', "spec/files/image.png")
      select 'New', from: 'Condition'
      select 'Books', from: 'Category'
      # check 'Collection' 
      select "Collection", from: "Delivery"
      fill_in 'Location', with: 'My Location'
      # # fill_in 'Tags', with: 'Education'
      # # select 'Education', from: 'Tags'
      # # select2("Education", from: "Tags")
      click_button 'Create Listing'
    end


    # # Home page 
    # specify "I can find this new listing in my listing page" do
    #   create_new_listing
    #   click_link "My Listings"
    #   save_and_open_page
    #   expect(page).to have_content 'My Title'
      
    # end

    # specify "I can click 'Edit' button on that listing" do 
      
    #   create_new_listing
    #   click_link "My Listings"
    #   click_link "Edit"
    #   expect(page).to have_content "Updating Listing" 
    # end 

    # specify "I can click 'See Details' " do 
    #   create_new_listing
    #   click_link "My Listings"
    #   click_link "See Details"
    #   expect(page).to have_content "My Title"
    # end 

    # specify "I can delete my listing" do 
    #   create_new_listing
    #   expect(page).to have_content 'Listing was successfully created.'
    #   click_link "My Listings"
    #   expect(page).to have_content 'My Title'
    #   click_link "Delete"
    #   expect(page).not_to have_content 'My Title'
    # end

    # # Message page didn't work yet due to listing can't not show 
    # specify "I can see my conversations with different users" do 
    #   @status_active = ListingStatus.create(id:20, name: "Active")

    #   @iphone_post = Listing.create(title: 'Iphone', listing_condition_id: 2, price: 500, listing_category_id: 3, listing_status_id: 20 )
    #   visit '/listings'
    #   save_and_open_page
    #   expect(page).to have_content 'Iphone'
      
    # end 

    # specify "I can check out all my favourite listings " do
      
    #   visit '/'
    #   click_link "heart-link"
    #   click_link "Favourate"
    #   expect(page).to have_content 'User2 listing'

    # end 
    # need countinue after reviews finished 
    # specify "check the reviews" do
    #   visit '/'
    #   click_link "Reviews"
    #   expect(page).to have_content "Leave a Review"
    #   expect(page).to have_content "My Reviews"
    # end 

    # routing error
    # specify "I can checkout my setting page and choose when to got email notifications " do 
    #   visit '/'
    #   click_link "Settings"
    #   check "email"
    #   select "All", from: "when"
    #   choose "Weekly"
    #   click_button "Save"
    #   expect(page).to have_content "succussful?"
    # end 

    # specify "I could create a new listing" do
    #   create_new_listing
    #   expect(page).to have_content 'Listing was successfully created.'
    # end

    # need to be finish by backend 
    # specify "Swapping Items" do 
    #   visit '/'
    #   click_button "See Details"
    #   click_button "Swap"
    #   expect(page.status_code).to eq 500
    # end 

    # Failure/Error: render 'update_success'
    # specify "I can editing my listings" do 
    #   create_new_listing 
    #   visit '/'
    #   click_link "My Listings"
    #   click_link "Edit"

    #   fill_in "Title", with: "My New Title"
    #   fill_in 'Price', with: '321'
    #   fill_in 'Description', with: 'My new description'
    #   select 'Used', from: 'Condition'
    #   select 'Books', from: 'Category'
    #   select "Postage", from: "Delivery"

    #   fill_in 'Location', with: 'New Location'

    #   click_button 'Update Listing'
    #   click_link "My Listings"
    #   expect(page).to have_content "My New Title"
    #   expect(page).to have_content "My new description"
    #   expect(page).to have_content "£ 321"
    # end


    # search function havent deployed
    # specify "Search listing by inputing keyword " do
    #   visit '/'
    #   fill_in "Search Bar", with: "A title for a post"
    #   click_button "Confirm"
    #   expect(page).to have_content "A title for a post"
    #   visit '/'
    #   select2("Education", from: "Select Tags")
    #   click_button "Confirm"
    #   expect(page).to have_content "Book"
    # end

    # specify "I can sort listings by different options" do
    #   visit '/'
    #   click_button "Sort By Title"
    #   click_button "Sort By Price"
    #   click_button "Sort by Date Created"
    #   # could be done by unit test
    # end

    # havent deployed yet 
    # specify "I can filter through items by different options" do
    #   visit '/'
    #   select 'Electronics', from: 'Categories'
    #   fill_in "Max Price", with: "200"
    #   select 'Used', from: 'Condition'
    #   check "Collection"
    #   check 'Drop-off'
    #   check 'Postage'
    #   click_button 'Confirm'
    #   expect(page).to have_content "Airpods"
    #   expect(page).not_to have_content "Iphone"
    # end

    # specify "I can view COVID-19 guidance in website" do
    #   visit '/'
    #   expect(page).to have_content "COVID-19 Guidance"
    # end

    # specify "As a buyer, I can review a seller I have purchased an item from " do
    #   visit '/'
    #   click_link "Reviews"
    #   expect(page).to have_content "a sold listing"
    #   click_button "Review"
    # end

    # specify "As a seller, I can review a buyer who has purchased an item from me" do
    #   visit '/'
    #   click_link "Reviews"
    #   expect(page).to have_content "a sold listing by me"
    #   click_button "Review"
    # end
  

    # specify "I can check FAQ page" do
    #   visit '/'
    #   click_link "FAQ"
    #   expect(page).to have_content "Frequently Asked Questions"
    #   expect(page).to have_current_path('/faq')
    # end

    # specify "I can check About page" do
    #   visit '/'
    #   click_link "About"
    #   expect(page).to have_content "About this site"
    #   expect(page).to have_current_path('/about')
    # end

    # specify "I can check Contact page" do
    #   visit '/'
    #   click_link "Contact"
    #   expect(page).to have_content "Get in touch"
    #   expect(page).to have_current_path('/contact')
    # end

    # specify "I can add a listing to my favourite listings " do
    #   # https://stackoverflow.com/questions/51457862/capybara-click-button-with-no-text-or-id
    #   visit '/'
    #   find('a.heart-link').click
    #   visit '/profile/user_favourites'
    #   # https://stackoverflow.com/questions/12851932/rails-capybara-how-to-click-a-link-in-a-table-row-that-also-contains-unique-tex
    #   # https://stackoverflow.com/questions/37405002/capybara-ambiguous-matching-link-or-button-nil

    # end

    # specify "I can't access admin page" do 
    #   visit '/admin/other'
    #   expect(page.status_code).to eq 403
    # end

    # specify "I cannot perform an SQL injection attack" do
    #   # Check search is not vulnerable to SQL injection
    #   page.driver.submit :post, search_and_filter_listings_path(search: { search_and_filter: "Iphone') OR '1'--" , filter_category: @category_books }), {}
    #   expect(page).not_to have_content 'Iphone'
    #   expect(page).not_to have_content 'Iphone'
    # end

    # specify "My html in sanitised to avoid XSS attacks", js: true do
    #   visit '/'
    #   click_link 'Create Listing'
    #   save_and_open_page
    #   fill_in 'Title', with: 'My Title'
    #   fill_in 'Price', with: '123'
    #   fill_in 'Description', with: 'My description'

    #   select 'New', from: 'Condition'
    #   select 'Books', from: 'Category'
    #   select "Collection", from: "Delivery"
    #   fill_in 'Location', with: 'My Location'
  
    #   fill_in 'Description', with: "<h1>Hello</h1>
    #                             <script>
    #                               $(function() {
    #                                 window.location.replace('http://api.rubyonrails.org/classes/ActionView/Helpers/SanitizeHelper.html');
    #                               });
    #                             </script>"
    #   click_button 'Create Listing'
    #   sleep(2)
    #   expect(current_url).not_to eq 'http://api.rubyonrails.org/classes/ActionView/Helpers/SanitizeHelper.html'
    #   # expect(page).to have_css 'h1'
    #   # within(:css, 'h1') { expect(page).to have_content 'Hello' }
    # end

    # specify "I cannot create a post as another user through abuse of mass assignment", js: true do
    #   visit new_listing_path
    #   fill_in 'Title', with: 'A controversial title'
    #   fill_in 'Price', with: '123'
    #   fill_in 'Description', with: 'My description'
    #   select 'New', from: 'Condition'
    #   select 'Books', from: 'Category'
    #   select "Collection", from: "Delivery"
    #   fill_in 'Location', with: 'My Location'
    #   page.execute_script "$('#posts-form').append(\"<input value='#{@admin.id}' name='post[author_id]'>\")"
    #   sleep 1
    #   click_button 'Create Listing'
    #   # not sure why creator function is not working  undefined method `creator' for nil:NilClass
    #   expect(Listing.last.creator).not_to eq @admin
    # end

    # specify "I cannot edit the details of another user" do
    #   visit settings_path(@admin)
    #   expect(page.status_code).to eq 200
    # end

  end



  context 'As a logged in admin' do
    before do

      admin = FactoryBot.create(:user, administrator: true, givenname: "give_admin", sn: "sn", id: 101)
      user = FactoryBot.create(:user, id: 100, administrator: false, username: "username", uid: "username", mail: "username@sheffield.ac.uk", ou: "COM", dn: "dn", sn: "SN", givenname: "givenname", email: "username@sheffield.ac.uk")
      # @condition_new = ListingCondition.create(name: "New")
      # @condition_used = ListingCondition.create(name: "Used")
      # @category_electronics = ListingCategory.create(name: "Electronics")
      # @category_cloting = ListingCategory.create(name: "Cloting")
      # @category_books = ListingCategory.create(name: "Books")
      # @status_pending = ListingStatus.create(id: 10, name: "Pending")
      # @status_complete = ListingStatus.create(id: 20, name: "Complete")
      # @status_active = ListingStatus.create(id:2, name: "Active")

      @iphone_post = Listing.create(title: 'Iphone', listing_condition_id: 2, price: 500, listing_category_id: 3 )
      @airpods_post = Listing.create(title: 'Airpods', listing_condition_id: 2, price: 200, listing_category_id: 3)

      @pending_post = Listing.create(title: 'A pending listing', listing_status_id: 10, is_active: true, creator_id: 100 )
      @pending_approve_posy = Listing.create(title: 'A pending listing need to approve', listing_status_id: 10, is_active: true, creator_id: 100 )
      login_as(admin, scope: :user)
    end
    # render error
    # specify "I can promote and demote other users as admin " do
    #   # https://stackoverflow.com/questions/12851932/rails-capybara-how-to-click-a-link-in-a-table-row-that-also-contains-unique-tex
    #   # visit "/"
    #   # click_link "Other"
    #   # click_link "Add a new admin"
    #   visit "/admin/promote_user"
    #   fill_in "Username", with: "username"
    #   fill_in "Email", with: "username@sheffield.ac.uk"
      
    #   click_button "Add admin"
    #   visit "/"
    #   click_link "Other"
    #   save_and_open_page
    #   expect(page).to have_content "username"
    #   # within_fieldset('Admin permissions') do
    #   #   click_button "Remove"
    #   # end
    #   find(:xpath, "//tr[td[contains(.,'username')]]/td/a", :text => 'Remove').click
    #   expect(page).not_to have_content "username@sheffield.ac.uk" 
    # end

    # specify "I can moderate new postings before they are released" do
    #   user = FactoryBot.create(:user,  administrator: false)
    #   login_as user
    #   visit '/'
    #   save_and_open_page
    #   expect(page).to have_content "Airpods"
    #   # click_link 'Create Listing'
    #   # fill_in 'Title', with: 'A pending listing'
    #   # fill_in 'Price', with: '123'
    #   # fill_in 'Description', with: 'My description'
    #   # select 'New', from: 'Condition'
    #   # select 'Books', from: 'Category'
    #   # # check 'Collection'
    #   # fill_in 'Location', with: 'My Location'
    #   # # # fill_in 'Tags', with: 'Education'
    #   # # # select 'Education', from: 'Tags'
    #   # # # select2("Education", from: "Tags")
    #   # click_button 'Create Listing'
    #   # admin = FactoryBot.create(:user, administrator: true)
    #   # login_as(admin, scope: :user)
    #   # visit '/'
    #   # save_and_open_page
    #   # expect(page).to have_content "A pending listing"
    #   # click_link "Moderation"
      
      
    #   # need approve case here
    #   # click_button "See Details"
    #   # click_button "Delete"
    #   # expect(page).not_to have_content "A pending listing"
    # end

    # specify "I can send emails notifications to all users" do
    #   visit '/'
    #   click_link "Other"
    #   fill_in "Send an email...", with: "Everyone should follow COVID-19 guidance"
    #   click_button "Send"
    #   expect(page).to have_content "The announcement has been sent to all user."
    # end

    # specify "I can view statistics pertaining to the usage of the website" do
    #   visit '/'
    #   click_link "Statistics"
    #   expect(page).to have_content "Site Traffic"
    #   expect(page).to have_content "Items sold"
    #   expect(page).to have_content "Items swapped"
    #   expect(page).to have_content "Overall item value sold"
    #   expect(page).to have_content "Top Categories"
    # end
    # # @javascript
    # specify "I can add or remove questions and answers in FAQ page" do
    #   visit '/'
    #   click_link "Other"
    #   click_button "Add a new question"
    #   fill_in "Question", with: "Hello, I have a question."
    #   fill_in "Answer", with: "Hello, I have an answer."
    #   click_button "Add question"
    #   visit '/faq'
    #   expect(page).to have_content "Hello, I have a question."
    #   expect(page).to have_content "Hello, I have an answer."
    #   visit '/admin/other'
    #   within_fieldset('FAQs') do
    #     click_button "Remove"
    #   end
    #   expect(page).not_to have_content "Hello, I have a question."
    # end

    # specify "I can add or remove ban words" do
    # end

    # specify "I can update COVID guidance context" do
    #   visit '/admin/other'
    #   within_fieldset('Edit the site...') do
    #     fill_in "COVID Guidance", with: "no more guidance"
    #     click_button "Save changes"
    #   end
        
    # end

    # # https://stackoverflow.com/questions/20134085/how-to-select-option-in-drop-down-using-capybara
    # # https://ryanbigg.com/2020/09/react-select-capybara-selenium
    # specify "I can add and delete ban words " do
    # end

  end
end
