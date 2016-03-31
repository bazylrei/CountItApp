platform :ios, '9.0'
use_frameworks!

def core_pods
     pod 'RxSwift'
     pod 'RxCocoa'
end

def test_pods
     pod 'Quick'
     pod 'Nimble'
end

def crash_pods
    pod 'Fabric'
    pod 'Crashlytics'
end

target 'ClickerApp' do
    core_pods
    crash_pods
end

target 'ClickerAppTests' do
   core_pods 
   test_pods
end

target 'ClickerAppUITests' do

end

target 'ClickerApp WatchKit Extension' do
    platform :watchos, '2.0'
    core_pods
end
