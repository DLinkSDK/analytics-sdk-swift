# AnalyticsKit
AnalyticsKit is a lightweight analytics library for iOS applications that provides:
- Event tracking and reporting
- Custom parameter support
- Automatic time correction
- Data persistence with WCDB
- Thread-safe operations

## Installation

### CocoaPods

```ruby
source 'https://github.com/DLinkSDK/deeplink-dev-specs.git' #DLINK
source 'https://cdn.cocoapods.org/' 

pod 'AnalyticsKit'
```

## Usage

### Get AccountId and DevToken
Register an account at [https://console.dlink.cloud/](https://console.dlink.cloud). After creating an app on the platform, get the corresponding AccountId and DevToken of the app.

### Initialization

```swift
import AnalyticsKit

// Configure Analytics
let config = AnalyticsConfig(accountId: "your_account_id", devToken: "your_dev_token")


// Initialize
Analytics.setup(with: config)
```

### Register DataService
```swift
let dataStore = DefaultDataStore() // use default data store or implement your own DataStore
let dataSender = MyDataSender() // implement your own DataSender
let dataService = DefaultDataService(dataStore: dataStore, dataSender: dataSender)
Analytics.register(service: dataService)
```

### Logging Events

```swift
// Log a simple event with default priority
Analytics.log(eventName: "button_click")

// Log an event with parameters and priority
Analytics.log(
    eventName: "purchase",
    eventParams: ["product_id": "123", "price": 99.9],
    priority: 1
)

// Add custom parameters
Analytics.addCustomParams(["user_level": "10"])
```

###  Event Reporting
AnalyticsKit will automatically report events in the background. 

If you need to report events manually, you can use the following method:
```swift
Analytics.flush()
```
Typically, you can call this method when the user switches tabs or ViewControllers.
## Requirements

- iOS 13.0+
- Swift 5.0+

## License

AnalyticsKit is available under the MIT license. See the LICENSE file for more info.
