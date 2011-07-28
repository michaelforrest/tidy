Put images in this folder and run

rake library:images

to automatically generate an ActionScript mapping class.

Edit the library:images task in tasks/library.rb

Usually you will want to be more domain-specific with your library files, 
e.g. rake library:playback_controls, rake library:carousel_elements, etc..
'images' is a generic term that should be avoided in production.
