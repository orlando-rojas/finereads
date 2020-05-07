# Stories

## User personas

There is just one type of user for this application that will be referred as "User".

## Stories

### User can see landing page

As an User, I want to see a landing page for the site, so that I can get started
with using it.

- Given that I am on the root url of the site "/"
- Then I see [landing page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=2%3A1)

### User can see the navbar

As an user, I want to see a navbar, so that I can nagivate the site.

- Given that I am in any page that is not the landing page
- Then I see the navbar
- And I see the logo
- And I see the link to "find books"
- And I see the "my books" link
- When I click the "find books" link, I am send to the search page
- When I click the "my books" link, I am send to the my books page

### User can see search page

As an User, I want to have a page to search for books for my library.

- Scenario 1: From the landing page
  - Given that I am on the landing page
  - When I click Get Started
  - Then I see the [search page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=2%3A76) with its empty state
  - And I see the search input
  - And I see that the search input has the placeholder "Search a book..."
- Scenario 2: From any page
  - Given that I am on any page that have a visible navbar
  - When I click on the navbar link "Find Books"
  - Then I see the [search page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=2%3A76)
  - And I see the search input
  - And I see that the search input has the placeholder "Search a book..."

#### Implementation notes

The search page should on the route "/search"

### User can search for a book

As an user, I want to be able to search a book, so that I can
add it to my personal library.

- Given that I am on the search page
- And I type a search query in the search input
- And I hit enter or click on the search button
- Then I see a [list of books that match my query](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=16%3A6)

#### Implementation notes

The list should show up to 8 books.

The list can be retrieved from the [Google book API](https://developers.google.com/books/docs/v1/using)
using the [volumes endpoint](https://developers.google.com/books/docs/v1/using#UserLocation).

The search should use a query parameter. Since this is retrieving resources, it
should use the GET method.

### User can see the details of a book

As an user, I want to learn more about a book, before adding it to my reading list.

- Given that I am on the search page
- And I have done a search query
- When I click the cover photo of a book
- Then I see the [book detail page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=23%3A0)
- And I see the title, cover and author of the book
- And I see the book description, with each paragraph separated correctly.
- And I see a button to purchase the book
- When I click the purchase button
- I am taken to the [google play book purchase page](https://play.google.com/store/books/details?id=ENFgDwAAQBAJ&rdid=book-ENFgDwAAQBAJ)

#### Implementation notes

The detail of the book should be on the route "/books/:book_id".

You can request the book data by id using the [retrieving a specific volume](https://developers.google.com/books/docs/v1/using#RetrievingVolume)
endpoint. 

Our recommendation for this is to not store the data from a specific volume in any model,
but to always query it when the route "/books/:book_id" is requested.

Link to the google play purchase pay is in the API response.

The page from the design uses the data from [this url](https://www.googleapis.com/books/v1/volumes/ENFgDwAAQBAJ)

### User can add a book to reading list

As a User I can add a book to my reading list so that I can start tracking their status and add notes.

**Preconditions**
- Given that I'm on the search page
- And I have done a [search query](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=16%3A6)

- Scenario 1
    - When I click on "Want to Read"
    - Then the book is added to my reading list with the status "Want to Read"
    - And I am taken to the [my books page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=44%3A68)
- Scenario 2 
    - When I click on "Mark as read"
    - Then the book is added to my reading list with the status "Read"
    - And I am taken to the [my books page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=44%3A68)

### User can edit a book

As a User I want to edit a book of my reading list so that I can change their status and note.

- Given that I'm on the "My books" page
- When I click on the pencil icon of a book
- I'm taken to the [book edit page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=28%3A177)
- And I see the cover, title, author
- And I see the current reading status and notes of the book.
- And I can change the reading status
- And I can change the notes
- When I click the button "Save"
- The changes are saved
- And I'm taken to [my books page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=44%3A68)

#### Implementation notes

The reading status options are: Want to read, Reading, Read.

### User can delete a book

As a User I can delete a book of my reading list so that I no longer track it.

- Given that I'm on the [my books page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=44%3A68)
- When I click on the trash icon of a book
- The book is deleted from the list
- And the page shows the list of books updated

### User see footer

As an user, I want to see a custom signature at the end of any page, so
that I know more about the amazing team the built this fine app.

- Given that I am on any page that is not the landing page
- When I look at the bottom of the page
- I see the codeable team signature
- And I see a github icon with a link to a fork that has the code of this project.

#### Implementation details

You should replace my signature with one from your team! It should include the names of you all.

## Optional stories

### User can see empty state for search page

As an user, I want to be more aware that I need to make a search, before
being able to see any book.

- Given that I am on the search page
- And I have not made any query
- Then I see the "Waiting for a query" message with its icon.

### User can add a book from the detail page.

As an user, I want to be able to add a book to my reading list from its
detail page, so that I can first get a better sense of what the book is about
before committing to reading it.

- Given that I am on the detail page of any book
- When I look under the book cover
- I see the "Want to Read" button
- And I see the "Mark as read" button
- When I click any of those buttons
- Then I add the book to my reading list with the correct status
- And I'm taken to [my books page](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=44%3A68).

#### Implementation notes

This is basically the same as "User can add a book to reading list" but from the
detail page.

### User can see if a book is saved from the detail page

As an user, I want to see if a book is saved when I see its detail page, 
so that I can avoid adding a book twice and perform more actions.

- Given that I am on any book detail page that I have saved in my reading list.
- When I look under the cover of the book
- Then I see the [status of the book](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=28%3A140) (Read, Reading, Want to read)
- And I see the "edit" and "delete" actions next to the status.
- When I click any of the actions, then the action is done exactly the
same as when the action is clicked from the "my books" page

#### Implementation details

[Design for status "Read"](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=32%3A21)

### User can search the books by a specific parameter

As an user, I want to be able to search books by title, author, publisher, subject
or isbn, so that I can find the book that I want to read.

- Given that I am on the search page
- When I look at the search input
- [I see a select button with the default option "All"](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=44%3A293)
- When I click the select button 
- Then I see a list of all the possible search parameters
- When I click any option
- [Then that option is selected](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=65%3A0)
- When I submit a query
- Then I see results that take into consideration the search parameter I selected.

#### Implementation notes

Possible options are: "By title", "By author", "By publisher", "By subject", and "By isbn".

The Books api allows to add search terms when querying for [books](https://developers.google.com/books/docs/v1/using#RetrievingVolume)

The "All" option just does the normal search query, the others use the search term config from google.

## Double optionals

### User can see more books

As an User, I want to be able to load more books, so that I can find the book I am looking for.

- Given I am on the book search page
- And I performed a query
- And there are more books than the ones the results show
- When I look at the bottom of the page
- Then I see the "Load More" button
- When I click the "Load More" button
- Then the page reloads
- And I see the next 40 books that the query has
- And I don't see the "Load more" button anymore

#### Implementation notes

The api has a way to paginate the results.

It should first show the first 8 books with the button, then the next 40 without the button. The
user can see 48 books in total.

### User can sort books

As an user, I want to be able to sort the results I see, so that I can better find
the book I am looking for.

- Given I am on the search page
- And I have done any search 
- [Then I see the sort select with the default "relevance"]([](https://p-VVF5MJM.t2.n0.cdn.getcloudapp.com/items/JrubonX9/Image%202020-05-07%20at%2001.00.56.png?v=9ee3a90aa8024104be00a44172e463b7))
- When I click it
- I see the options other option "newest".
- When I click that option
- The page is refreshed and I see the results sorted.

#### Implementation notes

This story requires that a form is automatically sent when a select input changes
(the one with the sort). That needs some JS to happen, so I left in this repo
an example of how to do it in [auto-submit-form](./auto-submit-form.html)

### User can filter reading list

As an user, I want to be able to filter the books I see in "my books" page by
status, so that I can see what I have read, what I'm reading or what I want
to read.

- Given that I am on the "my books" page
- [Then I see a select at the top right of the table with the default "All"](https://www.figma.com/file/waNRFjYyJHmzYRKj1eGnfK/Finereads?node-id=25%3A0)
- When I click it
- I see the filter options "Reading", "Read" and "Want to read"
- When I select one
- The page is refreshed
- And I see the book table filtered by my selection.

#### Implementation notes

This story requires that a form is automatically sent when a select input changes
(the one with the sort). That needs some JS to happen, so I left in this repo
an example of how to do it in [auto-submit-form](./auto-submit-form.html)