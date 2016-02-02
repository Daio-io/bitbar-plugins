#!/usr/bin/env /usr/local/bin/node

'use strict';

const got = require('/usr/local/lib/node_modules/got');

const itunesAppUrl = 'https://critiq-api.herokuapp.com/ios?appid=APP_ID_HERE';

got(itunesAppUrl)
  .then(response => {

    const data = JSON.parse(response.body);

    if (data.status === 'success') {

      let reviews = data.reviews;
      let reviewCount = reviews.length > 5 ? 5 : reviews.length;
      if (reviewCount > 0) {

        for (let i = 0; i < reviewCount; i++) {

          let review = reviews[i].short + ' ' + reviews[i].stars + '⭐️';

          console.log(review);
        }
      } else {
        console.log('No reviews yet |color=red');

      }
    }
  })
  .catch(() => {
    console.log('Error fetching reviews');
  });
