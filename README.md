# Set up

1. Install dependencies :
```
make bootstrap
```
2. On your application targets’ “General” settings tab, in the "Link Binary with Libraries" section, drag and drop each framework you want to use from the Carthage/Build folder on disk.

3. On your application targets’ “Build Phases” settings tab, click the “+” icon and choose “New Run Script Phase”. Create a Run Script with the following contents:

```
/usr/local/bin/carthage copy-frameworks
```
and add the paths to the frameworks you want to use under “Input Files”, e.g.:

```
$(SRCROOT)/Carthage/Build/iOS/Box.framework
$(SRCROOT)/Carthage/Build/iOS/Result.framework
$(SRCROOT)/Carthage/Build/iOS/ReactiveCocoa.framework
$(SRCROOT)/Carthage/Build/iOS/SwifyJSON.framework
$(SRCROOT)/Carthage/Build/iOS/AFNetworkingFramework.framework
```

# Recreating the bug

This project is composed of two unit tests :
- The first unit test makes an asynchronous HTTP request to google.
- The second unit test makes an asynchronous **HTTPS** request to google.

We observe that both tests succeed in XCode.

Let's try to launch tests from the command line with `xcodebuild` first.

```
xcodebuild -configuration Debug -scheme sample_bug -sdk iphonesimulator8.4 -destination 'platform=iOS Simulator,name=iPhone 6,OS=8.4' test
```

We get the following output :
```

Test Suite 'All tests' started at 2015-08-17 15:35:06 +0000
Test Suite 'sample_bugTests.xctest' started at 2015-08-17 15:35:06 +0000
Test Suite 'sample_bugTests' started at 2015-08-17 15:35:06 +0000
Test Case '-[sample_bugTests.sample_bugTests testHTTPNetworkReachable]' started.
Test Case '-[sample_bugTests.sample_bugTests testHTTPNetworkReachable]' passed (0.352 seconds).
Test Case '-[sample_bugTests.sample_bugTests testHTTPSNetworkReachable]' started.
Test Case '-[sample_bugTests.sample_bugTests testHTTPSNetworkReachable]' passed (0.222 seconds).
Test Suite 'sample_bugTests' passed at 2015-08-17 15:35:06 +0000.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.574 (0.577) seconds
Test Suite 'sample_bugTests.xctest' passed at 2015-08-17 15:35:06 +0000.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.574 (0.578) seconds
Test Suite 'All tests' passed at 2015-08-17 15:35:06 +0000.
	 Executed 2 tests, with 0 failures (0 unexpected) in 0.574 (0.582) seconds
** TEST SUCCEEDED **
```

The tests suceeded !

Let's try the same command with xctool :
1. I installed the latest version of xctool.
2. I closed the running instance of my simulator opened by xcodebuild.

```
../../xctool/xctool.sh -configuration Debug -scheme sample_bug -sdk iphonesimulator8.4 -destination 'platform=iOS Simulator,name=iPhone 6,OS=8.4' -showTasks test
```

The output is the following :
```
Failures:

  0) -[sample_bugTests testHTTPSNetworkReachable] (sample_bugTests.xctest)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
2015-08-17 17:38:13.316 xctest[15388:86010] NSURLConnection/CFURLConnection HTTP load failed (kCFStreamErrorDomainSSL, -9807)
Invalid connection: com.apple.coresymbolicationd
/Users/xxxx/xxx/xxx/xctool_sample_project/bug_recreation/sample_bugTests/sample_bugTests.swift:63: failed - Network unreachable:
60                 expectation.fulfill()
61             }
62             else {
63                 XCTFail("Network unreachable")
                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
64             }
65
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

** TEST FAILED: 1 passed, 1 failed, 0 errored, 2 total ** (10056 ms)
```
