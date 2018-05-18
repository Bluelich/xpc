# Uncomment the next line to define a global platform for your project
platform :osx, '10.10'
inhibit_all_warnings!
# Swift or use dynamic frameworks
use_frameworks!

pod 'YYModel'

def pods_XPCDemo
    pod 'PeerTalk', :git => 'https://github.com/rsms/peertalk'
end
target 'XPCDemo' do
    pods_XPCDemo
end

target 'ExternalCamera' do
  # use_frameworks!
  pods_XPCDemo
end

def pods_xpc_connection
    pod 'XPCKit'
#    , :git => 'https://github.com/stevestreza/XPCKit'
end
target 'xpc_connection' do
    pods_xpc_connection
end

target 'xpc_connection_service' do
    pods_xpc_connection
end
