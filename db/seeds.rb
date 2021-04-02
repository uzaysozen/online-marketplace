# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Categories 
categories = ListingCategory.first_or_create([{id: 1, name: 'Books'}, {id: 2, name: 'Clothing'}, {id: 3, name: 'Electronics'}, {id: 4, name: 'Phones', parent_category_id: 3}])

# Item conditions
conditions = ListingCondition.first_or_create([{name: 'New'}, {name: 'Used'}, {name: 'For parts or not working'}])

# Listing status
listing_status = ListingStatus.first_or_create([{name: 'Pending'}, {name: 'Active'}, {name: 'Complete'}, {name: 'Deleted'}])

listing = Listing.create(is_active: false, is_moderated: false, title: "MSI", description: "A msi computer", price: 200, discounted_price: nil, location: "Crookesmoor", swap: false, listing_category_id: 4, creator_id: 2, moderator_id: 2, receiver_id: 2, listing_condition_id: 1, listing_status_id: 2)

user = User.create(email: "jsmith1@sheffield.ac.uk", username: "aca19js", uid: "aca19js", mail: "jsmith1@sheffield.ac.uk", ou: "COM", dn: "uid=aca19us,ou=Undergraduates,ou=Students,ou=Users...", sn: "Smith", givenname: "John", administrator: nil)