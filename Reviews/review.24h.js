#!/usr/bin/env /usr/local/bin/node

'use strict';

const got = require('/usr/local/lib/node_modules/got');
const cheerio = require('/usr/local/lib/node_modules/cheerio');

const itunesAppUrl = 'https://itunes.apple.com/gb/app/<PUT_APP_HERE>';

got(itunesAppUrl)
  .then(response => {
    let $ = cheerio.load(response.body);

    let reviews = $('.customerReviewTitle');
    let latestReview = reviews.get(0).children[0].data;

    if (latestReview) {
      console.log(latestReview);
    } else {
      console.log('No reviews found |color=red');
    }
})
.catch(error => {
  console.log('Error fetching reviews');
});
