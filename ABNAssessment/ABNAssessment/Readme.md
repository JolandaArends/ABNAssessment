# ``Readme``

## Practicalities
* Used Xcode 15.2 for this assessment, the latest official release at the time of writing (4-3-2024)
* Project supports iOS 15+, because Rajesh told me that that is the current deployment target of the ABN Amro app
* The app is SwiftUI and for iPhone only. 

## Considerations
Considerations that didn't have a place for comments in the code

### Wikipedia
* I adjusted the Wikipedia app in a way that it fits with the current used setup. This setup seems fine, so I didn't feel the need to do unnecessary refactoring.
* The warnings in the Wikipedia have nothing to do with the current changes. Therefor I haven't fixed them. I would create a ticket to make sure that would/could be picked up separately. 

### Demo app
* Next to picking a location that ABN Amro provided, the user can pick it's own from a map.
I think that provides a nicer and easier way for the user to choose coordinates than having to type them.
This also presents a nice use case, which I would normally discuss with the team: 
SwiftUI's `Map` doesn't have support for getting the location of a tap on the map, on iOS 15. 
There are multiple solutions to this, f.e.:
    - Update the deployment target to iOS 17, where we can make use of the `MapReader`. -> This is not an option if you want to support iOS 15+.
    - Find a solution that works (for now). -> F.e.: by placing a pin on the center of the map and use that location. Which is what I have done now.
    - Ask if there is time and/or budget to create a better solution. -> F.e. revert back to UIKit by creating a `UIViewRepresentable` that càn handle taps on the map. 
* Unit tests have been added, but not UI or snapshot tests, due to limiting the scope.
* Normally, the API would be a module. I kept it simple for this assessment. 
I did try to show some async/await code, since Rajesh told me that that is the way to go in the ABN Amro app.
* Since it's an assessment, and it's just not possible to show everything you know, I've limited the scope a little bit,. F.e. I've not added `LocalizedString`s' this time. Same goes for things like styles, 'ViewComponents', unlimited `Preview` options, centralized values for paddings and such, etc. 
I hope that the current state already shows that I value a great user interaction, as well as order, structure and simplicity in the code. Also, I hope you will take my word for it that I value team work, communication and the right mindset above all. 

If there are any questions or remarks, I'd be happy to discuss them!

