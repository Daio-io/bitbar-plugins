#!/usr/bin/env /usr/local/bin/node

'use strict';

const got = require('/usr/local/lib/node_modules/got');
const cheerio = require('/usr/local/lib/node_modules/cheerio');

const itunesAppUrl = 'https://itunes.apple.com/gb/app/<PUT_APP_HERE>';

got(itunesAppUrl)
  .then(response => {
    let $ = cheerio.load(response.body);
    let customerReviews = $('.customer-review');

    let reviews = customerReviews.find('.customerReviewTitle').get(0);
    let starRating = customerReviews.find('.rating').attr('aria-label');

    if (reviews) {
      let stars = starRating ? starRating.replace('stars', '⭐️') : '';
      console.log(reviews.children[0].data, stars);
    } else {
      console.log('No reviews yet |color=red');
    }
})
.catch(error => {
  console.log('Error fetching reviews', error);
});
