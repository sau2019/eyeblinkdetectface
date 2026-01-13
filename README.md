# eyeblinkdetectface
# RealTime Face Detection using AI Eye Blink and Facial Expression


**PLEASE READ THIS** before continuing or posting a [new issue](https://github.com/sau2019/eyeblinkdetectface/issues):

## Requirements

### iOS

- Minimum iOS Deployment Target: 12.0
- Xcode 15.3.0 or newer

Your Podfile should look like this:

platform :ios, '12.0'  # or newer version


# add this line:
$iOSVersion = '12.0'  # or newer version


### Android

- minSdkVersion: 21
- targetSdkVersion: 35
- compileSdkVersion: 35

## How to use package
Use this package as a library
Depend on it
Run this command:

With Flutter:
``` dart
 $ flutter pub add eyeblinkdetectface
```

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

``` dart
dependencies:
  eyeblinkdetectface: ^1.0.4

```
Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn more.

Import it
Now in your Dart code, you can use:
``` dart
import 'package:eyeblinkdetectface/eyeblinkdetectface.dart';

```

## Examples and Use Cases
You can use below code to test liveliness feature

```
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:eyeblinkdetectface_example/index.dart';

class M7ExpampleScreen extends StatefulWidget {
  const M7ExpampleScreen({super.key});

  @override
  State<M7ExpampleScreen> createState() => _M7ExpampleScreenState();
}

class _M7ExpampleScreenState extends State<M7ExpampleScreen> {
  //* MARK: - Private Variables
  //? =========================================================
  String? _capturedImagePath;
  final bool _isLoading = false;
  bool _startWithInfo = true;
  bool _allowAfterTimeOut = false;
  final List<M7LivelynessStepItem> _veificationSteps = [];
  int _timeOutDuration = 30;

  //* MARK: - Life Cycle Methods
  //? =========================================================
  @override
  void initState() {
    _initValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  //* MARK: - Private Methods for Business Logic
  //? =========================================================
  void _initValues() {
    _veificationSteps.addAll(
      [
        // M7LivelynessStepItem(
        //   step: M7LivelynessStep.smile,
        //   title: "Smile",
        //   isCompleted: false,
        // ),
        M7LivelynessStepItem(
          step: M7LivelynessStep.blink,
          title: "1. Blink",
          isCompleted: false,
        ),

        M7LivelynessStepItem(
          step: M7LivelynessStep.blink,
          title: "2. Blink",
          isCompleted: false,
        ),
      ],
    );
    Eyeblinkdetectface.instance.configure(
      contourColor: Colors.blue,
      thresholds: [
        // M7SmileDetectionThreshold(
        //   probability: 0.8,
        // ),
        M7BlinkDetectionThreshold(
          leftEyeProbability: 0.25,
          rightEyeProbability: 0.25,
        ),
        M7BlinkDetectionThreshold(
          leftEyeProbability: 0.25,
          rightEyeProbability: 0.25,
        ),
      ],
    );
  }

  void _onStartLivelyness() async {
    setState(() => _capturedImagePath = null);
    final String? response = await Eyeblinkdetectface.instance.detectLivelyness(
      context,
      config: M7DetectionConfig(
          steps: _veificationSteps,
          startWithInfoScreen: _startWithInfo,
          maxSecToDetect: _timeOutDuration == 100 ? 2500 : _timeOutDuration,
          allowAfterMaxSec: _allowAfterTimeOut,
          captureButtonColor: Colors.red,
          // customize with note point option

          // m7stringConstants: M7StringConstants(
          //   isNoteVisible: true, // default value is false,
          //   label: M7LabelStrings(
          //     noteText: "Custom text here" // if you don't pass value, it will show default string customized by sdk.

          //   )
          // )

          // customize with info screen label option

          //  m7stringConstants: M7StringConstants(
          //     label: M7LabelStrings(
          //       livelyNessDetection: "Custom text here",
          //       infoSubText: "Custom text here",
          //       goodLighting: "Custom text here",
          //       goodLightingSubText: "Custom text here",
          //       lookStraight: "Custom text here",
          //       lookStraightSubText: "Custom text here",
          //     )
          //   )

          //  default sdk option
          m7stringConstants: M7StringConstants(label: M7LabelStrings())),
    );
    if (response == null) {
      return;
    }
    setState(
      () => _capturedImagePath = response,
    );
  }

  String _getTitle(M7LivelynessStep step) {
    switch (step) {
      case M7LivelynessStep.blink:
        return "Blink";
      case M7LivelynessStep.turnLeft:
        return "Turn Your Head Left";
      case M7LivelynessStep.turnRight:
        return "Turn Your Head Right";
      case M7LivelynessStep.smile:
        return "Smile";
    }
  }

  String _getSubTitle(M7LivelynessStep step) {
    switch (step) {
      case M7LivelynessStep.blink:
        return "Detects Blink on the face visible in camera";
      case M7LivelynessStep.turnLeft:
        return "Detects Left Turn of the on the face visible in camera";
      case M7LivelynessStep.turnRight:
        return "Detects Right Turn of the on the face visible in camera";
      case M7LivelynessStep.smile:
        return "Detects Smile on the face visible in camera";
    }
  }

  bool _isSelected(M7LivelynessStep step) {
    final M7LivelynessStepItem? doesExist = _veificationSteps.firstWhereOrNull(
      (p0) => p0.step == step,
    );
    return doesExist != null;
  }

  void _onStepValChanged(M7LivelynessStep step, bool value) {
    if (!value && _veificationSteps.length == 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            "Need to have atleast 1 step of verification",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          backgroundColor: Colors.red.shade900,
        ),
      );
      return;
    }
    final M7LivelynessStepItem? doesExist = _veificationSteps.firstWhereOrNull(
      (p0) => p0.step == step,
    );

    if (doesExist == null && value) {
      _veificationSteps.add(
        M7LivelynessStepItem(
          step: step,
          title: _getTitle(step),
          isCompleted: false,
        ),
      );
    } else {
      if (!value) {
        _veificationSteps.removeWhere(
          (p0) => p0.step == step,
        );
      }
    }
    setState(() {});
  }

  //* MARK: - Private Methods for UI Components
  //? =========================================================
  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        "M7 Livelyness Detection",
      ),
    );
  }

  Widget _buildBody() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildContent(),
        Visibility(
          visible: _isLoading,
          child: const Center(
            child: CircularProgressIndicator.adaptive(),
          ),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Spacer(
          flex: 4,
        ),
        Visibility(
          visible: _capturedImagePath != null,
          child: Expanded(
            flex: 7,
            child: Image.file(
              File(_capturedImagePath ?? ""),
              fit: BoxFit.contain,
            ),
          ),
        ),
        Visibility(
          visible: _capturedImagePath != null,
          child: const Spacer(),
        ),
        Center(
          child: ElevatedButton(
            onPressed: _onStartLivelyness,
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 20,
              ),
            ),
            child: const Text(
              "Detect Livelyness",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(
              flex: 3,
            ),
            const Text(
              "Start with info screen:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            CupertinoSwitch(
              value: _startWithInfo,
              onChanged: (value) => setState(
                () => _startWithInfo = value,
              ),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(
              flex: 3,
            ),
            const Text(
              "Allow after timer is completed:",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            CupertinoSwitch(
              value: _allowAfterTimeOut,
              onChanged: (value) => setState(
                () => _allowAfterTimeOut = value,
              ),
            ),
            const Spacer(
              flex: 3,
            ),
          ],
        ),
        const Spacer(),
        Text(
          "Detection Time-out Duration(In Seconds): ${_timeOutDuration == 100 ? "No Limit" : _timeOutDuration}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Slider(
          min: 0,
          max: 100,
          value: _timeOutDuration.toDouble(),
          onChanged: (value) => setState(
            () => _timeOutDuration = value.toInt(),
          ),
        ),
        Expanded(
          flex: 14,
          child: ListView.builder(
            physics: const ClampingScrollPhysics(),
            itemCount: M7LivelynessStep.values.length,
            itemBuilder: (context, index) => ExpansionTile(
              title: Text(
                _getTitle(
                  M7LivelynessStep.values[index],
                ),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              children: [
                ListTile(
                  title: Text(
                    _getSubTitle(
                      M7LivelynessStep.values[index],
                    ),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  trailing: CupertinoSwitch(
                    value: _isSelected(
                      M7LivelynessStep.values[index],
                    ),
                    onChanged: (value) => _onStepValChanged(
                      M7LivelynessStep.values[index],
                      value,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


```

## Customization
You can customize note point and info screen label, To configure this you need pass below constants in M7DetectionConfig parameter

1. For enabling note point in liveliness screen
```
  m7stringConstants: M7StringConstants(
            isNoteVisible: true, // default value is false,
            label: M7LabelStrings(
              noteText: "Custom text here" // if you don't pass value, it will show default string customized by sdk.

            )
          )

```

2. You can customize info screen label also, like below
```
  m7stringConstants: M7StringConstants(
            label: M7LabelStrings(
              livelyNessDetection: "Custom text here",
              infoSubText: "Custom text here",
              goodLighting: "Custom text here",
              goodLightingSubText: "Custom text here",
              lookStraight: "Custom text here",
              lookStraightSubText: "Custom text here",
            )
          )

```

3. You can also use default sdk label in your app.
```

   m7stringConstants: M7StringConstants(
            label: M7LabelStrings()
  )

```


## Example app

Find the example app [here](https://github.com/sau2019/eyeblinkdetectface/tree/main/example).

## MIT License
``` License
Copyright 2025, S.Ranjan Kr.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
```


## Contributing

Contributions are welcome.
In case of any problems look at [existing issues](https://github.com/sau2019/eyeblinkdetectface/issues), if you cannot find anything related to your problem then open an issue.

Create an issue before opening a [pull request](https://github.com/sau2019/eyeblinkdetectface/pulls) for non trivial fixes.

In case of trivial fixes open a [pull request](https://github.com/sau2019/eyeblinkdetectface/pulls) directly.