# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Categories 
categories = ListingCategory.first_or_create([{id: 1, name: 'Books'}, {id: 2, name: 'Clothing, Shoes & Jewelry'}, 
  {id: 3, name: 'Electronics'}, {id: 4, name: 'Phones & Accessories'}, {id: 5, name: 'Appliances'}, 
  {id: 6, name: 'Beauty & Personal Care'}, {id: 7, name: 'Automotive Parts & Accessories'}, {id: 8, name: 'Arts, Crafts & Sewing'},
  {id: 9, name: 'CDs & Vinyl'}, {id: 10, name: 'Collectibles & Fine Art'}, {id: 11, name: 'Toys & Games'}, {id: 12, name: 'Garden & Outdoor'},
  {id: 13, name: 'Grocery & Gourmet Food'}, {id: 14, name: 'Handmade'}, {id: 15, name: 'Health, Household & Baby Care'}, {id: 16, name: 'Home & Kitchen'},
  {id: 17, name: 'Industrial & Scientific'}, {id: 18, name: 'Luggage & Travel Gear'}, {id: 19, name: 'Movies & TV'}, {id: 20, name: 'Musical Instruments'},
  {id: 21, name: 'Office Products'}, {id: 22, name: 'Pet Supplies'}, {id: 23, name: 'Sports & Outdoors'}, {id: 24, name: 'Tools & Home Improvement'}, {id: 25, name: 'Computers & Tablets'}])

# Item conditions
conditions = ListingCondition.first_or_create([{name: 'New'}, {name: 'Used'}, {name: 'For parts or not working'}])

# Delivery methods
delivery_methods = Delivery.first_or_create([{name: 'Collection'}, {name: 'Drop-off'}, {name: 'Postage'}])

# Listing status
listing_status = ListingStatus.first_or_create([{name: 'Pending'}, {name: 'Active'}, {name: 'Complete'}, {name: 'Deleted'}])

# Page Content
page_contents = PageContent.first_or_create([{key: 'Covid Guidance', content: 'Placeholder Text'}])