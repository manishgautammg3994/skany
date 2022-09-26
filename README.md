# skany
* TODO remove trim() from everywhere
* in seconactivity.java
Display display = ((WindowManager) getSystemService(WINDOW_SERVICE)).getDefaultDisplay();
@Override
public void onConfigurationChanged(Configuration newConfig) {
    super.onConfigurationChanged(newConfig);
    if(display.getOrientation() == 0)
        setContentView(R.layout.main_portrait);
    else
        setContentView(R.layout.main_landscape); //getOrientation gives 1 here
}


or just below supercreate
if(orientation==LANDSCAPE)
    setContentView(R.layout.main_landscape);
else
    setContentView(R.layout.main_portrait);

A new Flutter project.


to modify colors , launch button ,translations,alignment and drawer all features

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
``` kotlin
var wifiPattern = "(WIFI:S:)(.{1,32})(;T:)(WPA|WEP)(;P:)(.{1,32})(;;)".toRegex()
if (wifiPattern.matches(value)){}

// Parse
val infoArr = wifiPattern.find(value)?.groups
if (!infoArr.isNullOrEmpty() && infoArr.size == 8) {
    val ssid = infoArr[2]
    val password = infoArr[6]
    val type = infoArr[4]
}
```
```
String UPI = "upi://pay?pa=" + payeeAddress + "&pn=" + payeeName
            + "&tr=" + trxnRefId
            + "&tn=" + trxnNote + "&am=" + payeeAmount + "&cu=" + currencyCode+ "&ad="+ str ;
```
 ```dart
    // main.dart
void main() {
  const dummyString =
      "Welcome to https://www.kindacode.com and learn new things. Contact us at https://www.kindacode.com/contact or via email. Happy coding and have a nice day!";

  final RegExp exp = RegExp(r'(?:(?:https?):\/\/)?[\w/\-?=%.]+\.[\w/\-?=%.]+');
  List<RegExpMatch> matches = exp.allMatches(dummyString).toList();

  for (var match in matches) {
    print(dummyString.substring(match.start, match.end));
  }
}
    ```

    ```
    https://www.kindacode.com
https://www.kindacode.com/contact
    ```


    ```
    // main.dart
void main() {
  const input = "One two three four five six seven eight.";
  const startWord = "two";
  const endWord = "six";

  final startIndex = input.indexOf(startWord);
  final endIndex = input.indexOf(endWord, startIndex + startWord.length);

  final String? output =
      input.substring(startIndex + startWord.length, endIndex);
  print(output);
}
```
```
three four five
```
```
substring(int startIndex, [ int endIndex ])
```
```
void main() { 
   String str1 = "Hello World"; 
   print("New String: ${str1.substring(6)}"); 
   
   // from index 6 to the last index 
   print("New String: ${str1.substring(2,6)}"); 
   
   // from index 2 to the 6th index 
} 
```
```
New String: World 
New String: llo 
```



```
upi://pay?pa=8607573994@paytm&pn=MANISH&mc=0000&mode=02&purpose=00&orgid=159761