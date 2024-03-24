import UIKit

struct UpstoxShare: Codable {
    let symbol: String
    let quantity: Int
    let ltp: Float
    let avgPrice: Float
    let close: Float
}
