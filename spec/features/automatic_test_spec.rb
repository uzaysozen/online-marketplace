require 'rails_helper'

describe 'End to end test' do


  specify 'I cannot access the blog without logging in' do
    visit '/'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
  
  context 'As a logged in user' do

    before do
      user = FactoryBot.create(:user)
      login_as(user, scope: :user)
    end

    specify "I could create a new listing" do
      condition_new = FactoryBot.create :listing_condition, name: 'New'
      # condition_new = ListingCondition.create(name: "New")
      category_books = ListingCategory.create(name: "Books")
      # category_books = FactoryBot.create :listing_category, name: 'Books'
      visit '/'
      click_link 'Create Listing'
      fill_in 'Title', with: 'My Title'
      fill_in 'Price', with: '123'
      fill_in 'Description', with: 'My description'
      select 'New', from: 'Condition'
      select 'Books', from: 'Category'
      # check 'Collection'
      fill_in 'Location', with: 'My Location'
      # fill_in 'Tags', with: 'Education'
      click_button 'Create Listing'
      # visit '/listings'
      expect(page).to have_content 'Listing was successfully created.'
      
      # within(:css, 'container') { expect(page).to have_content 'My Title' }
    end

    # specify "I cannot perform an SQL injection attack" do
    #   # Check search works correctly
    #   page.driver.submit :post, search_result_posts_path(search: { title: "A title for a post" }), {}
    #   expect(page).to have_content 'A title for a post'
    #   expect(page).not_to have_content 'A title for a secret post'

    #   # Check search is not vulnerable to SQL injection
    #   page.driver.submit :post, search_result_posts_path(search: { title: "A title for a post') OR '1'--" }), {}
    #   expect(page).not_to have_content 'A title for a post'
    #   expect(page).not_to have_content 'A title for a secret post'
    # end

    # specify "I cannot access the admin only management section" do
    #   visit "/categories"
    #   expect(page.status_code).to eq 403
    #   expect(page).not_to have_content 'Manage categories'
    # end

    # specify "My html in sanitised to avoid XSS attacks", js: true do
    #   visit new_post_path
    #   fill_in 'Title', with: 'My title'
    #   fill_in 'Content', with: "<h1>Hello</h1>
    #                             <script>
    #                               $(function() {
    #                                 window.location.replace('http://api.rubyonrails.org/classes/ActionView/Helpers/SanitizeHelper.html');
    #                               });
    #                             </script>"
    #   click_button 'Create Post'
    #   sleep(2)
    #   expect(current_url).not_to eq 'http://api.rubyonrails.org/classes/ActionView/Helpers/SanitizeHelper.html'
    #   expect(page).to have_css 'h1'
    #   within(:css, 'h1') { expect(page).to have_content 'Hello' }
    # end

    # specify "I cannot make myself an administrator through abuse of mass assignment", js: true do
    #   visit '/'
    #   click_link 'Edit my details'
    #   page.execute_script "$('#user-form').append(\"<input value='t' name='user[admin]'>\")"
    #   sleep 1
    #   click_button 'Update User'
    #   expect(user2.reload.admin).to be false
    # end

    # specify "I cannot create a post as another user through abuse of mass assignment", js: true do
    #   visit new_post_path
    #   fill_in 'Title', with: 'A controversial title'
    #   fill_in 'Content', with: 'Some inflammatory context'
    #   page.execute_script "$('#posts-form').append(\"<input value='#{user1.id}' name='post[author_id]'>\")"
    #   sleep 1
    #   click_button 'Create Post'
    #   expect(Post.last.author).not_to eq user1
    # end

    # specify "I cannot edit the details of another user" do
    #   visit edit_user_path(user1)
    #   expect(page.status_code).to eq 403
    # end

  end

  # context 'As a non signed in user' do

  #   specify "I cannot sign up with a password that is too short" do
  #     visit "/users/sign_up"
  #     fill_in "Email", with: 'a.n@email.com'
  #     fill_in "Password", with: 'pass'
  #     fill_in "Password confirmation", with: 'pass'
  #     click_button 'Sign up'
  #     expect(page).to have_content 'is too short (minimum is 8 characters)'
  #     expect(page).to_not have_content 'Welcome! You have signed up successfully.'
  #   end

  #   specify "I can sign up with a long password" do
  #     visit "/users/sign_up"
  #     fill_in "Email", with: 'a.n@email.com'
  #     fill_in "Password", with: '3fNPg6fqScrZs0m3'
  #     fill_in "Password confirmation", with: '3fNPg6fqScrZs0m3'
  #     click_button 'Sign up'
  #     expect(page).to_not have_content 'is too long (maximum is 8 characters)'
  #     expect(page).to have_content 'Welcome! You have signed up successfully.'
  #   end

  #   specify "I cannot sign up with a simple password" do
  #     visit "/users/sign_up"
  #     fill_in "Email", with: 'a.n@email.com'
  #     fill_in "Password", with: 'alllowercase'
  #     fill_in "Password confirmation", with: 'alllowercase'
  #     click_button 'Sign up'
  #     expect(page).to have_content 'Password must contain at least one digit and Password must contain at least one upper-case letter'
  #     expect(page).to_not have_content 'Welcome! You have signed up successfully.'
  #   end

  #   specify "My account is locked if I enter my password wrong too many times" do
  #     visit "/users/sign_in"
  #     20.times do
  #       fill_in "Email", with: user2.email
  #       fill_in "Password", with: 'notmypassword'
  #       click_button 'Log in'
  #     end
  #     expect(page).to have_content 'Your account is locked.'
  #   end

  # end

  # context 'Audit log' do

  #   before do
  #     @public_post  = Post.create(title: 'A title for a post',        content: 'Some public content',  author: user1, private_post: false)
  #     @private_post = Post.create(title: 'A title for a secret post', content: 'Some private content', author: user1, private_post: true)
  #     @category = FactoryBot.create :category, name: 'My cat'
  #   end

  #   specify 'I cannot view the audit log as a normal user' do
  #     login_as user2
  #     visit "/audits"
  #     expect(page.status_code).to eq 403
  #   end

    # context 'As an admin' do
    #   before { login_as admin_user }

    #   specify 'I can see an audit log of categories' do
    #     visit "/categories"
    #     click_link 'Edit'
    #     fill_in 'Name', with: 'Updated cat'
    #     click_button 'Update Category'
    #     visit '/audits'
    #     within(:css, 'table') do
    #       expect(page).to have_content 'Category'
    #       expect(page).to have_content 'Name From: My cat - To: Updated cat'
    #     end
    #   end

    #   specify 'I can see a list of data accessed for categories', js: true do
    #     visit "/categories"
    #     click_link 'Edit'
    #     visit '/audits'
    #     click_link 'Views'
    #     within(:css, 'table') do
    #       expect(page).to have_content 'categories'
    #       expect(page).to have_content 'edit'
    #       expect(page).to have_content @category.id
    #     end
    #   end

    # end

  # end

end
