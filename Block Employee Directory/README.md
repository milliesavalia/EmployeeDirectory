## Build tools & versions used
- Swift, Xcode 14.2, Removed the main storyboard to setup for programmatic UI
- 3rd party library used: [SDWebImage](https://github.com/SDWebImage/SDWebImage) for image caching, adding directly through Xcode

## Steps to run the app
1. Open the Xcode Project file and let SPM pull the dependencies.
2. Build the 'Directory' scheme to your iOS simulator. I mostly used an iPhone SE and iPhone 14 to test.

## What areas of the app did you focus on?
- I focused on clean and easy to follow code, with a structure similar to what I've learned from prior experiences: keeping the cells/added views as dumb as possible and injecting only the information that it needs

## What was the reason for your focus? What problems were you trying to solve?
- Displaying an empty state view instead of an empty list when there are no employees to show was a fun part of the challenge and helped refine the structure that I ended up going with. I wanted to do most of the heavy lifting in the view model so that the controller was just able to present and delegate all of the information it recieved. I'm sure I could have come up with better ways of organising that structure but given the time restriction, I did what made the most sense for it to work and to be able to make future improvements upon.

## How long did you spend on this project?
- I spent around 7-8 hours on the project over the course of the week.

## Did you make any trade-offs for this project? What would you have done differently with more time?
- I chose to use a UITableView because I am more comfortable with it and went for simplicity. If I had spent more time I would have liked to use a UICollectionView and maybe created a grid view because it would be nicer design and can provide more flexibility when adding more features. 

## What do you think is the weakest part of your project?
- I think the weakest part of the project is the networking/service. If I had more time I would have looked into better logging of the errors for better user experience in the case of malformed employees.
- Could have used a UICollectionView instead
- Could have accomodated colors for dark mode
- Could have also written more thorough tests

## Did you copy any code or dependencies? Please make sure to attribute them here!
- Directions for removing main storyboard properly: [medium article](https://medium.com/@yatimistark/removing-storyboard-from-app-xcode-14-swift-5-2c707deb858)
- I pulled the Array extension at the bottom of the controller from a previous project
- Refreshed my knowledge of JSON Decoding: [SwiftLee](https://www.avanderlee.com/swift/json-parsing-decoding/)

## Is there any other information you’d like us to know?
- I really appreciated how well written the directions are and the added FAQ section. Enjoyed working through this challenge!
