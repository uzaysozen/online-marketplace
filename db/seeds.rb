# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Categories 
categories = ListingCategory.first_or_create([{name: 'Books'}, {name: 'Clothing'}, {name: 'Electronics'}])

# Item conditions
conditions = ListingCondition.first_or_create([{name: 'New'}, {name: 'Used'}, {name: 'For parts or not working'}])

# Listing status
listing_status = ListingStatus.first_or_create([{name: 'Pending'}, {name: 'Active'}, {name: 'Complete'}, {name: 'Deleted'}])
