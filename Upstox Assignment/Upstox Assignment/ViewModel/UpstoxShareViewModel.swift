import UIKit

class UpstoxShareViewModel: NSObject {

    // MARK: - Constants

    public static var userHolding: UserHolding? = nil
    private static let url = "https://run.mocky.io/v3/bde7230e-bc91-43bc-901d-c79d008bddc8"

    // MARK: - Networking

    public static func fetchUpstoxSahresUsingJSON(completion: @escaping (_ isSuccess: Bool) -> Void) {
        guard let urlString = URL(string: Self.url) else {
            completion(false)
            return
        }

        URLSession.shared.dataTask(with: urlString) { (data, _ , error) in
            DispatchQueue.global(qos: .background).async {
                guard let data, error == nil else {
                    completion(false)
                    return
                }

                do {
                    self.userHolding = try JSONDecoder().decode(UserHolding.self, from: data)
                    completion(true)
                } catch {
                    completion(false)
                    return
                }
            }
        }.resume()
    }

    // MARK: - Helpers

    public static func calculatePandLValue(upstoxShare: UpstoxShare) -> Float {
        let currentValue = upstoxShare.ltp * Float(upstoxShare.quantity)
        let investmentValue = upstoxShare.avgPrice * Float(upstoxShare.quantity)
        return currentValue - investmentValue
    }

    public static func calculateTotalCurrentValue() -> Float {
        guard let upstoxSharesArray = userHolding?.userHolding else {
            return 0
        }

        var totalCurrentValue: Float = 0
        for upstoxShare in upstoxSharesArray {
            totalCurrentValue += (upstoxShare.ltp * Float(upstoxShare.quantity))
        }
        return totalCurrentValue
    }

    public static func calculateTotalInvestmentValue() -> Float {
        guard let upstoxSharesArray = userHolding?.userHolding else {
            return 0
        }

        var totalInvestmentValue: Float = 0
        for upstoxShare in upstoxSharesArray {
            totalInvestmentValue += (upstoxShare.avgPrice * Float(upstoxShare.quantity))
        }
        return totalInvestmentValue
    }

    public static func calculateTodaysProfitAndLoss() -> Float {
        guard let upstoxSharesArray = userHolding?.userHolding else {
            return 0
        }

        var todaysPandL: Float = 0
        for upstoxShare in upstoxSharesArray {
            todaysPandL += ((upstoxShare.close - upstoxShare.ltp) * Float(upstoxShare.quantity))
        }
        return todaysPandL
    }
}
