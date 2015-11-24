import UIKit

//MARK: Leaf Node Protocols

protocol Windowable {
    var real: UIWindow { get }
    var rootViewController: UIViewController? { get set }
    var layer: CALayer { get }
    func makeKeyAndVisible()
}

protocol Screenable {
    var bounds: CGRect { get }
}