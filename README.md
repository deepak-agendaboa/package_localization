# package_localization

Experiment with the localization used from separate package. This project contains some string which
are translated already. It will use the localization based on your main project's (app) locale.

## Getting Started

- Add the package into your projects pubspec.yaml file:

```
dependencies:
  package_localization:
    git:
      url: https://github.com/deepak-agendaboa/packgae_localization
```

- Add the delegate `PackageLocalizations.delegate` in `localizationsDelegates` of MaterialApp.
