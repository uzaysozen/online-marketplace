# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Categories 
categories = ListingCategory.first_or_create([{id: 1, name: 'Books'}, {id: 2, name: 'Clothing'}, {id: 3, name: 'Electronics'}, {id: 4, name: 'Phones', parent_category_id: 3}])

# Item conditions
conditions = ListingCondition.first_or_create([{name: 'New'}, {name: 'Used'}, {name: 'For parts or not working'}])

# Delivery methods
delivery_methods = Delivery.first_or_create([{name: 'Collection'}, {name: 'Drop-off'}, {name: 'Postage'}])

# Listing status
listing_status = ListingStatus.first_or_create([{name: 'Pending'}, {name: 'Active'}, {name: 'Complete'}, {name: 'Deleted'}])