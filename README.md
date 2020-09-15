# Ninety-Nine Cats

Created as part of the App Academy curriculum. [Part 1](https://open.appacademy.io/learn/full-stack-online/rails/99-cats); [Part 2](https://open.appacademy.io/learn/full-stack-online/rails/99-cats-ii--auth)

View [Live App](https://pure-citadel-01791.herokuapp.com/).

### Functionality

Users can rent or add a cat, as well as delete and edit ones they own. Users can login to their accounts from multiple browsers and devices from the same time, and their sessions will persist. Users can also see where they are currently logged in as well as some info about each of their sessions. Users can logout of any session on their account page, not just their current one. Users will also see their cats and rental requests for cats they own on their account page, and can approve or deny them if these are still pending.

Various validations are in place for Users, Cats, and CatRentalRequests.

### Thoughts

This project is my first time using authentication and views.

My approach to allowing Users to have multiple sessions was to add a `sessions` table that keeps track of the `session_token` and `user_id`, as well as some info about the session. If a user logs out of a session, it is deleted from the `sessions` table. I don't know if this was the proper approach — I came up with it on my own.

I wanted to use `button_to` more, but couldn't find a way to display multiple buttons inline. (Dealing with CSS is beyond the scope of what I wanted to work on for this project.) I was running into errors because I used `method: :DELETE` instead of `method: :delete` (the former does not work). I learned that starting in Rails 5 each form gets its own authenticity token.

I ran into scary issues when I carelessly destroyed a migration file that I had already migrated. I didn't end up losing too much time on it, but I *did* have to reset my entire database, losing the data I had been playing around with in the process. I'm glad it happened in this project and not something I was more invested in. Good lesson to favor adding migrations to fix mistakes.

-Andrew Hayhurst