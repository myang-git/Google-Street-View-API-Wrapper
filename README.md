Install
=========================

To integrate the library with your iOS application, follow the steps below:

    1. Drag the Xcode project package GoogleStreetViewAPI.xcodeproj to your project navigator

    2. Click on your project. Choose the target. Then go to the Build Phases page. 
       Expand "Target Dependencies" and add GoogleStreetViewAPI to the list

    3. In the same Build Phases page, expand "Link Binary With Libraries", add libGoogleStreetViewAPI.a to the list
    
    4. Switch to the Build Settings page, go down to the Search Paths section. (if you have trouble finding it, type "header search" in the search field)
       Add the absolute path to the source code directory to the path list.

    5. Build the project and you are good to go!

How to Use
=========================

Here is the typical workflow:

    1. Import GoogleStreetViewAPI.h and GoogleStreetViewAPIDelegate.h
   
    2. Write a class implementing the protocol GoogleStreetViewAPIDelegate
    
    3. Create an instance of GoogleStreetViewAPI and call the initializer initWithImageWidth:imageHeight:usingSensor:
   
    4. Assign the delegate to the API instance
    
    5. The delegate method api:didReturnStreetViewImage: will be called when the image has been successfully downloaded. Otherwise api:failedReturnStreetViewImageWithError: will be called

The project has an working example TestGoogleStreetViewApp for iPhone. Please take a look as well.

Enjoy!