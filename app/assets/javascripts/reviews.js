load = (loadEvent) => {
    let reviewSelect = document.getElementById('review-select');

    // check review select exists
    if (reviewSelect) {
        // define review 
        let buyerReviews = document.getElementById('buyer-reviews');
        let sellerReviews = document.getElementById('seller-reviews');

        // change which reviews are shown on select change
        reviewSelect.addEventListener('change', (e) => {
            if (reviewSelect.value == 1) {
                buyerReviews.style.display = 'block';
                sellerReviews.style.display = 'none';
            }
            else {
                buyerReviews.style.display = 'none';
                sellerReviews.style.display = 'block';
            }
        })
    }
}

document.addEventListener('turbolinks:load', load);

