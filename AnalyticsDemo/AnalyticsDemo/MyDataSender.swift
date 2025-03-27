import Foundation
import AnalyticsKit

// customize data sender
class MyDataSender: NSObject, IDataSender {
    // implement send method
    // dataPackage: data package to send
    // finished: callback when send finished, pass true if send success, false if send failed
    func send(dataPackage: AnalyticsKit.DataPackage, finished: @escaping (Bool) -> Void) {
        print("send data package: \(dataPackage.eventsJson)")
        // simulate network delay
        let result = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            print("send data package result \(result)")
            finished(result)
        }
    }
}
