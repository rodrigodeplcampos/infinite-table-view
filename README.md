# InfiniteTableView

Proof of concept for a paginated UITableView, using B-VIPER, dependency injection and Flickr API. 
The idea of this exercise is to demonstrate these technologies working together to provide a cleaner code base and a highly flexible architecture.

## Why B-VIPER?

The VIPER architecture is well known for being highly reusable and maintainable. The addition of a "B" (stands for Builder) layer was proposed by Nicola Zaghini to provide a single entry point to the VIPER module, encapsulating all the necessary bindings and dependency injections, therefore, facilitating the module's construction. More information about the architecture can be found [here](https://github.com/nzaghini/b-viper).

## Third-party libraries

 * [Alamofire](https://github.com/Alamofire/Alamofire) Network library for Swift. It provides some pretty handy extensions as "AlamofireImage" (image download and cache) and "AlamofireObjectMapper" (JSON/Object mapper), both also being used on the project.
 * [Swinject](https://github.com/Swinject/Swinject). Dependency injection library for Swift. 
 * [Quick/Nimble](https://github.com/Quick/Quick) BDD framework for Swift.
 
 ## Usage
 
 Download or clone the project, add the FlickrAPIKey to the main bundle Info.plist file and run. The build method is being called on the AppDelegate class to construct the whole module and provide the entry UIViewController.

 It is possible to easily replace the FlickrImageService by any other that conforms to the ImageService protocol. The response model has to be replaced as well, but it will be parsed automatically by the ObjectMapper pod once it conforms to the Mappable protocol. The image model has to conform to the DownloadableImage protocol. 

The new service should then, be passed on the modules construction.

 ## Acess control

The project was designed to be used as-is or by an external project. In that second case, the only visible layers are the service and the builder. Further modifications such as View + Presenter or Interactor replacements are possible, but their protocols would have to be exposed.
