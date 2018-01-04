# BTNSDateFormatterFactory

Smart reuse of NSDateFormatter instances.

`NSDateFormatter` class is very useful to display dates the way you want, handling regional settings, locales and formats.

The bad thing about `NSDateFormatter` is the cost to create a new instance or set format and locale. Actually these actions are one of the most slow operations on iOS SDK and you really must avoid it.

`DFDateFormatterFactory` is here to help you with this. This class retain the last 15 date formatter instances and return the already loaded based on format and locale you want. Also, the cache were implemented using the standard `NSCache` and should handle memory fine when memory warnings happens.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

`BTNSDateFormatterFactory` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```
pod 'BTNSDateFormatterFactory'
```

or

To install the `BTDateFormatterFactory`, just drag and drop the .h and .m files into your project folder. Import them when you need it.

## Usage

```
NSDateFormatter *dateFormatter = [[BTNSDateFormatterFactory sharedFactory] dateFormatterWithFormat:@"yyyy-MM-dd" andLocaleIdentifier:@"zh_CN"];
```
## Author

BrooksWon, jianyu996@163.com

## License

BTNSDateFormatterFactory is available under the MIT license. See the LICENSE file for more info.
