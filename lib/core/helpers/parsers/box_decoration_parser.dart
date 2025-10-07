import 'package:cached_network_image/cached_network_image.dart'
    show CachedNetworkImageProvider;
import 'package:flutter/material.dart';
import 'package:font_story/core/constants/api.dart';
import 'package:font_story/core/extensions/string.dart';

/// A utility class with static methods to parse BoxDecoration-related JSON objects.
class BoxDecorationParser {
  static final Map<Map<String, dynamic>, BoxDecoration> _cache = {};

  static BoxDecoration? parseBoxDecoration(Map<String, dynamic>? json) {
    if (json == null) return null;
    if (_cache.containsKey(json)) return _cache[json];

    final decoration = BoxDecoration(
      image: _parseDecorationImage(json['image']),
      color: (json['color'] as String?)?.parseColor,
      borderRadius: _parseBorderRadius(json['borderRadius']),
      border: _parseBorder(json['border']),
      boxShadow: _parseBoxShadow(json['boxShadow']),
      gradient: _parseGradient(json['gradient']),
    );

    _cache[json] = decoration;
    return decoration;
  }

  static BorderRadius? _parseBorderRadius(Map<String, dynamic>? json) {
    if (json == null) return null;
    final all = (json['all'] as num?)?.toDouble();
    double getSide(String key) => (json[key] as num?)?.toDouble() ?? all ?? 0.0;

    return BorderRadius.only(
      topLeft: Radius.circular(getSide('topLeft')),
      topRight: Radius.circular(getSide('topRight')),
      bottomLeft: Radius.circular(getSide('bottomLeft')),
      bottomRight: Radius.circular(getSide('bottomRight')),
    );
  }

  static BoxBorder? _parseBorder(Map<String, dynamic>? json) {
    if (json == null) return null;
    final color = (json['color'] as String?)?.parseColor ?? Colors.transparent;
    double getWidth(String key) => (json[key] as num?)?.toDouble() ?? 0.0;
    final all = json['all'] as num?;
    return Border(
      top: BorderSide(color: color, width: all?.toDouble() ?? getWidth('top')),
      right: BorderSide(
        color: color,
        width: all?.toDouble() ?? getWidth('right'),
      ),
      bottom: BorderSide(
        color: color,
        width: all?.toDouble() ?? getWidth('bottom'),
      ),
      left: BorderSide(
        color: color,
        width: all?.toDouble() ?? getWidth('left'),
      ),
    );
  }

  static List<BoxShadow>? _parseBoxShadow(Map<String, dynamic>? json) {
    if (json == null) return null;
    return [
      BoxShadow(
        color: (json['color'] as String?)?.parseColor ?? Colors.black,
        blurRadius: (json['blurRadius'] as num?)?.toDouble() ?? 0.0,
        spreadRadius: (json['spreadRadius'] as num?)?.toDouble() ?? 0.0,
        offset: Offset(
          (json['offset']['dx'] as num?)?.toDouble() ?? 0.0,
          (json['offset']['dy'] as num?)?.toDouble() ?? 0.0,
        ),
      ),
    ];
  }

  static Gradient? _parseGradient(Map<String, dynamic>? json) {
    if (json == null) return null;
    final type = json['type'];
    final colors = (json['colors'] as List<dynamic>? ?? [])
        .map((c) => (c as String).parseColor ?? Colors.transparent)
        .toList();
    if (type == 'linear') {
      return LinearGradient(
        colors: colors,
        begin: _parseAlignment(json['begin']),
        end: _parseAlignment(json['end']),
      );
    }
    return null;
  }

  static Alignment _parseAlignment(Map<String, dynamic>? json) {
    if (json == null) return Alignment.center;
    return Alignment(
      (json['x'] as num?)?.toDouble() ?? 0.0,
      (json['y'] as num?)?.toDouble() ?? 0.0,
    );
  }

  static EdgeInsets? parsePadding(Map<String, dynamic>? json) {
    if (json == null) return null;
    final all = (json['all'] as num?)?.toDouble() ?? 0.0;
    double getSide(String key) => (json[key] as num?)?.toDouble() ?? all;

    return EdgeInsets.only(
      top: getSide('top'),
      right: getSide('right'),
      bottom: getSide('bottom'),
      left: getSide('left'),
    );
  }

  /// Lazy image loading: returns a provider but decoding happens on first paint
  static DecorationImage? _parseDecorationImage(Map<String, dynamic>? json) {
    if (json == null) return null;
    final String? url = json['url'];
    if (url == null || url.isEmpty) return null;

    final imageProvider = url.startsWith('/assets')
        ? CachedNetworkImageProvider('$baseUrl$url')
        : AssetImage(url);

    ColorFilter? colorFilter;
    if (json['color'] != null) {
      final color = (json['color'] as String).parseColor;
      colorFilter = ColorFilter.mode(color!, BlendMode.srcIn);
    }

    return DecorationImage(
      image: imageProvider as ImageProvider<Object>,
      fit: _parseBoxFit(json['fit']),
      alignment: _parseAlignment(json['alignment']),
      opacity: (json['opacity'] as num?)?.toDouble() ?? 1.0,
      colorFilter: colorFilter,
    );
  }

  static BoxFit _parseBoxFit(String? value) {
    switch (value) {
      case 'contain':
        return BoxFit.contain;
      case 'fill':
        return BoxFit.fill;
      case 'fitWidth':
        return BoxFit.fitWidth;
      case 'fitHeight':
        return BoxFit.fitHeight;
      case 'none':
        return BoxFit.none;
      case 'scaleDown':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }
}
