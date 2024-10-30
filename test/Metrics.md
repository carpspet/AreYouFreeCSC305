HEART Framework link: https://docs.google.com/presentation/d/13-iKmA1yd9ZLfNA-cSWpkgm0vclyl1A-mE4lcZTV660/edit?usp=sharing 

* NPS
  * After users have used the app for a certain amount of time and have an understanding of the app, they will be prompted to leave a review in the app store out of 5 stars.
  * Once the user completes a review they will be granted a limited theme which can be tracked through firebase.
  * Offer a limited theme that is granted once you complete the review.
* Adoption
  * Number of app downloads
  * Number of friends, shared events, or number of events created
* DAU
  * The daily active users can be monitored by firebase realtime database to see unique users over 30, 7, and 1 day time periods.
  * Flutter flow also has a similiar tool through google analytics.
* Retention
  * Firebase analytics will log user sessions and track how often these users return to the app.
  * Track events to monitor specific features that encourage retention like adding events or syncing calendars.
  * We will track the retention rate by measuring percentage of users who come back to the app within 1 day, 7 days, and 30 days after their first session.
* CTR for an event on the Golden Path. This is done with Firebase Analytics custom event.
  * Firebase analytics with tell us how many times a user interacts with something on our golden path, be it a button, event, or something else
  * We can compare the CTR (the Click Through Rate) with how many times users were given the opportunity to click something (an impression)
