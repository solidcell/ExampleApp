import UIKit

/***********************
 Leaf Objects - Real Implementations
 
 These are the leaves of the object graph, representing sources of
 input and output: view controllers, configurations, network libraries, etc.
 
 These are replaced by fake implementations during tests
***********************/

extension UIScreen: Screenable {
}