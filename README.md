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

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
