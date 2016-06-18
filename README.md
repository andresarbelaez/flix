# Project 2 - *Flix*

**Flix** is a movies app using the [The Movie Database API](http://docs.themoviedb.apiary.io/#).

Time spent: **14** hours spent in total

## User Stories

The following **required** functionality is complete:

- [x] User can view a list of movies currently playing in theaters from The Movie Database.
- [x] Poster images are loaded using the UIImageView category in the AFNetworking library.
- [x] User sees a loading state while waiting for the movies API.
- [x] User can pull to refresh the movie list.

The following **optional** features are implemented:

- [ ] User sees an error message when there's a networking error.
- [ ] Movies are displayed using a CollectionView instead of a TableView.
- [x] User can search for a movie.
- [x] All images fade in as they are loading.
- [x] User can view the large movie poster by tapping on a cell.
- [ ] For the large poster, load the low resolution image first and then switch to the high resolution image when complete.
- [x] Customize the selection effect of the cell.
- [x] Customize the navigation bar.
- [x] Customize the UI. Implemented icons from iconmonstr. Added UI animations.

The following **additional** features are implemented:

- [x] Customize the search bar
- [x] Movie vote average is shown (scale 1-10)... A function determines the display color of these ratings (red, yellow, or green).
- [x] Release Date is shown in details view
- [x] User can scroll in details view to see movie overview
- [x] On app launch, an initial message is shown
- [x] A tab bar is implemented for user to navigate between Now Playing, Top Rated, and Popular
- [x] **Proof of concept**: a webView pushes user to a Fandango search of the current movie.

Please list two areas of the assignment you'd like to **discuss further with your peers** during the next class (examples include better ways to implement something, how to extend your app in certain ways, etc):

1.
2.

## Video Walkthrough

Here's a walkthrough of implemented user stories:
<img src='https://i.imgur.com/d6JjNR3.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />
<img src='https://i.imgur.com/pudHthp.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

GIF created with [LiceCap](http://www.cockos.com/licecap/).

## Notes

I experienced many challengings while building this app. Some of these challenges included handling optionals returning nil, and implementing different endpoint calls to the Movies Database API.

## Credits

List an 3rd party libraries, icons, graphics, or other assets you used in your app.

- [AFNetworking](https://github.com/AFNetworking/AFNetworking) - networking task library
- [iconmonstr](http://iconmonstr.com) - library of icons

## License

    Copyright [2016] [Andres Arbelaez]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
