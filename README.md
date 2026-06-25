# flutter_gn_fancyleds_card

A customizable card widget featuring an animated LED border and a vibrant background glow effect for Flutter applications.

[![GitHub license](https://img.shields.io/github/license/GeorgeNady/flutter_gn_fancyleds_card)](https://github.com/GeorgeNady/flutter_gn_fancyleds_card/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/GeorgeNady/flutter_gn_fancyleds_card)](https://github.com/GeorgeNady/flutter_gn_fancyleds_card/stargazers)

## Features

- **Ambilight (Ambient) Effect**: A content-aware mode that extracts colors from your child widget's edges to create a perfectly matching ambient glow and border.
- **Animated LED Border**: A beautiful sweeping gradient border that rotates smoothly based on the sampled colors.
- **Vibrant Glow Effect**: A soft background glow that shifts dynamically along with the border colors.
- **SOLID Architecture**: Built with clean code principles, allowing for custom image processors and easy extensibility.
- **Highly Customizable**: Easily adjust border width, glow radius, and border radius.

## Getting started

Since this package is hosted on GitHub, you can add it to your `pubspec.yaml` using:

```yaml
dependencies:
  flutter_gn_fancyleds_card:
    git:
      url: https://github.com/GeorgeNady/flutter_gn_fancyleds_card.git
      ref: main
```

## Usage

### Simple Example

```dart
FancyLedCard(
  glowRadius: 50,
  child: Container(
    width: 300,
    height: 150,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.blue.shade900,
      borderRadius: BorderRadius.circular(24),
    ),
    child: const Text(
      'Hello Ambient LED!',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
    ),
  ),
)
```

## Parameters

### FancyLedCard

| Parameter | Type | Default | Description |
|---|---|---|---|
| `child` | `Widget` | **Required** | The widget to display inside the fancy card. |
| `borderWidth` | `double` | `2.0` | The width of the sweeping animated border. |
| `glowRadius` | `double` | `40.0` | The blur radius and spread extent of the color glow layer. |
| `borderRadius` | `BorderRadius` | `BorderRadius.circular(24)` | The clip and decoration border radius for the card. |
| `controller` | `FancyLedController?` | `null` | Controller for external control and manual refreshes. |
| `color` | `Color?` | `null` | Primary color used if ambient data is not yet available. |
| `processor` | `IImageProcessor?` | `AmbilightProcessor()` | Custom strategy for ambient pixel sampling. |

## License

MIT
