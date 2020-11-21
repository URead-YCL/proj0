Original App Design Project - README
===

# URead

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
3. [Schema](#Schema)

## Overview
### Description
URead has 2 main features. 
Firstly, users can search for books and add them to "bookshelf". URead also recommends books based on users' perviously added books. 
Secondly, users can post reviews to their added books and share the reviews to FB or WeChat. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Book/Education
- **Mobile:** real-time book recommend
- **Story:** Allow users to add books to their list, post and share book reviews, and get recommended books based on their previously added books
- **Market:** Anyone who enjoys reading would enjoy the app. (Optional) Users can read book reviews posted by others
- **Habit:** An habit-forming app. Users can post reviews everytime they finish reading a few chapters. 
- **Scope:** The product is narrow-focused. Basically, it mimics the process of searching for books in bookstores and writing personal reviews while reading. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User use WeChat or FB account to login
* Recommend books based on the user's previously added books
* User can search any book by typing in keywords
* User can click a book and see the details (rating, overview)
* User can click the add button and add a book to bookshelf
* User can post their review notes of a book
* User can share their notes

**Optional Nice-to-have Stories**

* Profile pages for each user
* Settings (Accesibility, Notification, General, etc.)

### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account
    * WeChat, FB
* Streams
   * Home (book recommendation)
   * Bookshelf
   * Notes
* Detail
    * User can view the specifics of a book
* Creation
    * User can create a new note that appears on top of the 'Notes'

Optional
* Settings
* Profile

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home
* Booksshelf

Optional
* Settings

**Flow Navigation** (Screen to Screen)

* Home
   * Book cell(Home)->Book Details
   * Search for books

* Bookshelf
   * Book cell(Bookshelf) -> Notes -> Textfield to be modified 

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
