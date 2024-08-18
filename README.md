### How to run this app:

Navigate to the root directory and run
`bundle install`
`bin/rails db:create db:migrate`

Next, run `rails server` and navigate to localhost:3000

You can test by running `bundle exec rspec spec` as well as `rubocop`.

### Notes:
1. I implemented a bit of vanilla JS. If this app were to grow then it would make sense to perhaps add a framework such as Vue.js. Given the size of the app, it wouldn't make sense to add so much extra tech debt.
2. I moved file processing and file validations into their own services. This helps with not only organization but should other formats be included in the future such as .CSV, it'll make it easy to add.
3. I added front-end validation for file size and type as well as back end validation. In my opinion it's always a good idea to have both for things of this nature since we can let the user know the file isn't acceptable before hitting the server.
4. The submit button is disabled until a file is actually uploaded so that empty forms don't get submitted.
5. There is a drag and drop feature as well as a file upload in order to remove as many barrier to file upload for the user as possible.
6. There is a blank-state screen as well as a content-state screen. I didn't want to show an empty table if there are no records, and instead show text to further entice the end-user to upload a document.
7. It is sortable by first name and by vehicle type. Since we are showing full name, I decided to do a first name sort but as the application grows, I believe a last name sort is what would ultimately make sense, and showing the names like: last_name, first_name.
8. The length parser was moved into a separate module since it is used in both the Vehicle model as well as the FileService. The reason here is that I wanted to make sure we are using the same code for both validating and saving as those happen in different classes.
9. There is the addition of Hotwire Turbo to create an improved front-end experience when uploading files.

### Additional Optimizations and Future-Thinking
1. Changing the vehicle length column type to a float rather than an integer to support partial feet lengths (or other units of measurement
2. Making the vehicle type enum more flexible or adding additional options since as the app grows vehicle types may not fit perfectly into these categories.
3. In the future it may make sense to implement a Template Method design pattern for various vehicle types to inherit from a Vehicle class
4. Can also implement a lot more user data such as returning customers so we know if they have pre-saved vehicles.
5. Based on the assignment parameters, there was a one-to-one relationship between vehicles and customers. In the future I can see a one-to-many relationship between customers and vehicles.
6. More descriptive error handling such as showing exactly which line failed.
7. Handling duplicate records. If a file is successful it currently says imported 4 records rather than specifying duplicate records.

