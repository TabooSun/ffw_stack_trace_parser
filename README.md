A simple command-line application for parsing Flutter for Web Stack Trace.

## Installation:
```shell
dart pub global activate -s git https://github.com/TabooSun/ffw_stack_trace_parser.git
```

- You need to reload your shell session after running this.
 
## Update
- Run the same script to update it.

## Usage:

- Say that you have an error message in a file (`crash-file.txt`) as such:
```text
MissingPluginException(No implementation found for method isRealDevice on channel trust_fall)
    at Object.d (http://localhost:30001/main.dart.js:19668:3)
    at http://localhost:30001/main.dart.js:111178:15
    at cDb.a (http://localhost:30001/main.dart.js:31458:62)
    at cDb.$2 (http://localhost:30001/main.dart.js:67199:14)
    at cBx.$1 (http://localhost:30001/main.dart.js:67193:21)
    at aWr.zc (http://localhost:30001/main.dart.js:68621:33)
    at cni.$0 (http://localhost:30001/main.dart.js:67689:11)
    at Object.a_Y (http://localhost:30001/main.dart.js:31603:40)
    at ak.An (http://localhost:30001/main.dart.js:67606:3)
    at cna.$0 (http://localhost:30001/main.dart.js:67653:13)
```

- Run this command:
```shell
ffw_stack_trace_parser --source-map build/web/main.dart.js.map -i crash-file.txt
```

- It will print this:
```text
org-dartlang-sdk:///lib/_internal/js_runtime/lib/js_helper.dart 1111:37                              wrapException
../../../../../../Development/flutter/packages/flutter/lib/src/services/platform_channel.dart 154:7  MethodChannel._invokeMethod
org-dartlang-sdk:///lib/_internal/js_runtime/lib/async_patch.dart 317:19                             _wrapJsFunctionForAsync
org-dartlang-sdk:///lib/_internal/js_runtime/lib/async_patch.dart 342:23                             _wrapJsFunctionForAsync.<anonymous function>
org-dartlang-sdk:///lib/_internal/js_runtime/lib/async_patch.dart 293:19                             _awaitOnObject.<anonymous function>
org-dartlang-sdk:///lib/async/zone.dart 1687:46                                                      _RootZone.runUnary
org-dartlang-sdk:///lib/async/future_impl.dart 124:29                                                _FutureListener.handleValue
org-dartlang-sdk:///lib/async/future_impl.dart 796:13                                                _Future._propagateToListeners
org-dartlang-sdk:///lib/async/future_impl.dart 602:5                                                 _Future._completeWithValue
org-dartlang-sdk:///lib/async/future_impl.dart 640:7                                                 _Future._asyncCompleteWithValue.<anonymous function>
```
