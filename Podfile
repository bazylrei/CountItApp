platform :ios, '9.0'
use_frameworks!

def core_pods
     pod 'RxSwift',    '~> 2.0'
     pod 'RxCocoa',    '~> 2.0'
end

def test_pods
     pod 'Quick', '~> 0.8.0'
     pod 'Nimble', '~> 3.0.0'
end

target 'ClickerApp' do
    core_pods
end

target 'ClickerAppTests' do
    test_pods
end

target 'ClickerAppUITests' do

end

target 'ClickerApp WatchKit Extension' do
    platform :watchos, '2.0'
    core_pods
end
