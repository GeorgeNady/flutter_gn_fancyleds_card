# flutter_gn_fancyleds_card

A customizable card widget featuring an animated LED border and a vibrant background glow effect for Flutter applications.

[![GitHub license](https://img.shields.io/github/license/GeorgeNady/flutter_gn_fancyleds_card)](https://github.com/GeorgeNady/flutter_gn_fancyleds_card/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/GeorgeNady/flutter_gn_fancyleds_card)](https://github.com/GeorgeNady/flutter_gn_fancyleds_card/stargazers)

## Features

- **Animated LED Border**: A beautiful sweeping gradient border that rotates smoothly around the child widget.
- **Vibrant Glow Effect**: A soft background glow that shifts dynamically along with the border color.
- **Ambilight (Ambient) Mode**: A content-aware mode that extracts colors from your child widget's edges to create a perfectly matching ambient glow and border.
- **SOLID Architecture**: Built with clean code principles, allowing for custom image processors and easy extensibility.
- **Highly Customizable**: Easily adjust border width, glow radius, border radius, and animation modes.
- **Multiple LED Modes**: `staticColor`, `breathing`, `rainbow`, `rainbowWave`, `pulse`, `chase`, and `ambient`.

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
  child: Container(
    width: 300,
    height: 150,
    alignment: Alignment.center,
    child: const Text(
      'Hello LED!',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    ),
  ),
)
```

### Ambilight (Ambient) Mode

This mode samples pixels from the child widget to create a immersive lighting effect.

```dart
FancyLedCard(
  mode: LedMode.ambient,
  glowRadius: 50,
  child: Image.network('https://example.com/movie_poster.jpg'),
)
```

### Custom Configuration with Controller

```dart
final controller = FancyLedController(color: Colors.orange);

FancyLedCard(
  controller: controller,
  mode: LedMode.staticColor,
  borderWidth: 4.0,
  glowRadius: 50.0,
  borderRadius: BorderRadius.circular(16),
  child: const Padding(
    padding: EdgeInsets.all(24.0),
    child: Icon(Icons.bolt, size: 48, color: Colors.amber),
  ),
)
```

## Parameters

### FancyLedCard

| Parameter | Type | Default | Description |
|---|---|---|---|
| `child` | `Widget` | **Required** | The widget to display inside the fancy card. |
| `mode` | `LedMode` | `LedMode.rainbow` | The operational mode for the LED animation effects. |
| `borderWidth` | `double` | `2.0` | The width of the sweeping animated border. |
| `glowRadius` | `double` | `40.0` | The blur radius and spread extent of the color glow layer. |
| `borderRadius` | `BorderRadius` | `BorderRadius.circular(24)` | The clip and decoration border radius for the card. |
| `controller` | `FancyLedController?` | `null` | Controller for external control and manual refreshes. |
| `color` | `Color?` | `null` | Static color for `staticColor` mode (overrides controller). |
| `processor` | `IImageProcessor?` | `AmbilightProcessor()` | Custom strategy for ambient pixel sampling. |

## License

MIT
