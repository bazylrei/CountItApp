![Banner](/Web/banner.png)
[![Build Status](https://travis-ci.org/PiXeL16/CountItApp.svg?branch=master)](https://travis-ci.org/PiXeL16/CountItApp/) [![codecov.io](https://codecov.io/github/PiXeL16/CountItApp/coverage.svg?branch=master)](https://codecov.io/github/PiXeL16/CountItApp?branch=master) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/PiXeL16/CountItApp/master/LICENSE)

[![DownloadAppStore](/Web/appstorebadge.png)](https://itunes.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=1098893335&mt=8)

# Count It
Never lose the count again.
Dead simple App with Apple Watch integration that lets you count anything.

* Laps while exercising.
* How many beers you drink at the pub.
* Days since you quit smoking.
* Glasses of water you drink during the day.
* People that enter your restaurant or club.
* Sheep while you sleep 😜

Count It has two way communication between the App and the Watch, meaning that you can start your count on your Watch and continue it on your Phone and vice versa.

Tapping anywhere on the App or Watch face adds to the counter and gives you haptic feedback. You don't have to look at your Watch while counting!

To decrement or clear the counter, force press on your watch face.

Includes a watch complication and glance that lets you easily check and access the count.

You can also modify the look to several color options to fit your style.

The step count can also be modify so you can count in higher numbers not just one by one.


Screenshots
---
<img src="/Web/Screenshot1.jpg" width="250">

<img src="/Web/Screenshot2.jpg" width="250">

<img src="/Web/Screenshot3.jpg" width="250">

<img src="/Web/Screenshot4.jpg" width="250">

Watch Screenshots
---
<img src="/Web/watchScreenshot1.jpg" width="250">

<img src="/Web/watchScreenshot2.jpg" width="250">

<img src="/Web/watchScreenshot4.jpg" width="250">

<img src="/Web/watchScreenshot5.jpg" width="250">

The Code
---

### Installation

This project comes with a `Makefile` to simplify the onboarding of the project.

To bootstrap the project just clone the repo, navigate to the root directory on terminal and run the following command:

```console
make bootstrap
```

This will install all the gems specified in the `Gemfile` as well as installing all the dependencies specified by the `Podfile`.

In case `bundler` is not detected the `Makefile` target will fail.

There are multiple targets supported by the `Makefile` which can be easily know by running:

```console
make help
```

### Details

The idea of the app was to play with WatchKit 2 and try to create something in a couple of days.

Perhaps, one of the most interesting parts its the two way communication between the App and the Watch.

![TwoWayCommunication](/Web/twoWayCommunicatio.gif)

All of these is wrapped into the `WatchSessionManager.swift`.

`ApplicationContextChangedDelegate` is use as a delegate pattern to let other objects 'register' to events from the `WCSession`.

```swift
//Add view model to the datasource delegate so we get application context changes
       watchSession.addDataSourceChangedDelegate(self)
```
This is the only thing something like a `ViewModel` will need to register to these events.

## View Models
[MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) is use throughout the app. All of this ViewModels classes are shared along the iOS and Watch targets.

This makes it extremely easy to setup things like `Glances` and `Interface Controllers` in the WatchKit side of things.

All `ViewModels` expose [RxSwift](https://github.com/ReactiveX/RxSwift) observables in the form of [Drivers](https://github.com/ReactiveX/RxSwift/blob/master/Documentation/Units.md) that are perfect to use in `ViewModels` because they:
* can't error out
* observe on main scheduler
* sharing side effects (shareReplayLatestWhileConnected)

`ViewControllers` can later connect to this drivers and update UI Elements, for example:

```swift
viewModel.clickerCountDriver?
         .map { $0.description }
         .driveNext{ [weak self] count in

          self?.updateCountLabelWithAnimation(count)

         }.addDisposableTo(disposeBag)
```

This will update the counter label with an animation to latest information.

## Data Storage
`NSUserDefault` is use as the Datastore since the data is really simple. All Model objects implement `NSCoding` and are saved by using the `NSKeyedArchiver`.

```swift
let data = NSKeyedArchiver.archivedDataWithRootObject(object)

defaults.setObject(data, forKey: key)

defaults.synchronize()

```

## Protocols
There are several protocols like `Dictionable` and `Timeable` that encapsulates some good amount of functionality, making it very easy update models objects.


TODO
-----
* Set a Goal of counts, so you know when you are near your Goal.
* Better code coverage
* Improve animations on Watch
* Watch UI Testing (Not supported by Apple)

:alien: Author
------
Chris Jimenez - http://code.chrisjimenez.net, [@chrisjimeneznat](http://twitter.com/chrisjimeneznat)

:beer: Donate
------
If you want to buy me a beer, you can donate to my coin addresses below:
#### BTC
1BeGBew4CBdLgUSmvoyiU1LrM99GpkXgkj
#### ETH
0xa59a3793E3Cb5f3B1AdE6887783D225EDf67192d
#### LTC
Ld6FB3Tqjf6B8iz9Gn9sMr7BnowAjSUXaV

## License
`Count It` is released under the MIT license. See [LICENSE](https://github.com/pixel16/CountItApp/blob/master/LICENSE) for details.