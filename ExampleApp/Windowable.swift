import Foundation

protocol Windowable: class {
    var rootViewController: ViewPresenting? { get set }
}