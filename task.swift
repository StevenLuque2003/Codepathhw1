import UIKit
import CoreLocation

struct Task {
    var title: String
    var description: String
    var image: UIImage?
    var location: CLLocationCoordinate2D?
    var isCompleted: Bool = false
}
