# InfiniteTableView

Proof of concept for a paginated UITableView, using B-VIPER, dependancy injection and Flickr API. 
The idea of this exercise is to demonstrate this technologies working together in order to provide a cleanner code base and a highly flexible architecture.

## Why B-VIPER?

The VIPER architecture is well known for being highly flexible and maintainable. The addition of a "B" (stands for Builder) layer was proposed by Nicola Zaghini to provide a single entry point to the VIPER module, encapsulating all the necessary bindings and dependancy injections therefore facilitating the module's construction. More information about the architecture can be found [here](https://github.com/nzaghini/b-viper).

## Third-party libraries

 * [Alamofire](https://github.com/Alamofire/Alamofire) Network library for Swift. It provides some pretty handy extensions as "AlamofireImage" (image download and cache) and "AlamofireObjectMapper" (JSON/Object mapper), both also being used on the project.
 * [Swinject](https://github.com/Swinject/Swinject). Dependancy injection library for Swift. 
 * [Quick/Nimble](https://github.com/Quick/Quick) BDD framework for Swift.
