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

* [x] User can sign up and log in with Parse
* [x] User can search any book by typing in keywords
* [x] User can click a book and see the details (rating, overview)
* [x] User can click the add button and add a book to bookshelf
* [x] User can post their review notes of a book

**Optional Nice-to-have Stories**

* [x] Profile pages for each user

### 2. Screen Archetypes

* Login
* Register - User signs up or logs into their account
    * Parse
* Streams
   * Home (book search)
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
* My Bookshelf
* Profile

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
<img src="https://github.com/URead-YCL/proj0/blob/main/design/UIDesign11.30.jpeg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
| Property      | Type | Description |
| ----------- | ----------- | ----------- | 
| objectId      | String   | id for the user post | 
| Note   | String  | notes posted by user to a book | 
| Added   | Boolean  | whether a book has previously been added | 
| BooksCount   | Number  | number of books added by a user | 
| NotesCount   | Number  | number of notes added by a user | 
| updatedAt   | DateTime  | date when a note is last updated | 

### Networking
* Home Screen
   - (Read/GET) Query books from GoogleBooks API (20/time).
   - (Create/POST) Press "+" and add the book to my bookshelf. 
   - (Delete) Delete existing "+"
* My bookshelf Screen
   - (Read/GET) Query all books added by the user
   * My notes Screen
      - (Read/GET) Query all notes posted by the user to the book
   * Create notes Screen
      - (Create/POST) Create a new note
* Profile Screen
   - (Read/GET) Query logged in user object
   - (Update/PUT) Update user's profile image

#### [OPTIONAL:] Existing API Endpoints
GoogleBooks: https://www.googleapis.com/books/v1/volumes?q=best+inauthor:keyes&key=AIzaSyAnDwfERI10Wm5E4LANV8SJJxuT5mL9Slo

###Gifs to show build progress
[Add picture of your hand sketched wireframes in this section]
<img src="https://s31.aconvert.com/convert/p3r68-cdx67/64nvx-wn6t9.gif" width=600>
