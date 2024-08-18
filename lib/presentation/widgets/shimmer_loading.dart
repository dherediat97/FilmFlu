import 'package:film_flu/app/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Shimmer extends StatefulWidget {
  static ShimmerState? of(BuildContext context) {
    return context.findAncestorStateOfType<ShimmerState>();
  }

  const Shimmer({
    super.key,
    this.child,
  });

  final Widget? child;

  @override
  ShimmerState createState() => ShimmerState();
}

class ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;
  final _shimmerGradient = const LinearGradient(
    colors: [
      AppColors.secondaryColor,
      Color(0xFFF4F4F4),
      AppColors.secondaryColor,
    ],
    stops: [
      0.1,
      0.3,
      0.4,
    ],
    begin: Alignment(-1.0, -0.3),
    end: Alignment(1.0, 0.3),
    tileMode: TileMode.clamp,
  );

  @override
  void initState() {
    super.initState();

    _shimmerController = AnimationController.unbounded(vsync: this)
      ..repeat(min: -0.5, max: 1.5, period: const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  LinearGradient get gradient => LinearGradient(
        colors: _shimmerGradient.colors,
        stops: _shimmerGradient.stops,
        begin: _shimmerGradient.begin,
        end: _shimmerGradient.end,
        transform:
            _SlidingGradientTransform(slidePercent: _shimmerController.value),
      );

  bool get isSized =>
      (context.findRenderObject() as RenderBox?)?.hasSize ?? false;

  Size get size => (context.findRenderObject() as RenderBox).size;

  Offset getDescendantOffset({
    required RenderBox descendant,
    Offset offset = Offset.zero,
  }) {
    final shimmerBox = context.findRenderObject() as RenderBox?;
    return descendant.localToGlobal(offset, ancestor: shimmerBox);
  }

  Listenable get shimmerChanges => _shimmerController;

  @override
  Widget build(BuildContext context) {
    return widget.child ?? const SizedBox();
  }
}

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0.0, 0.0);
  }
}

class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({
    super.key,
    required this.isLoading,
    required this.child,
  });

  final bool isLoading;
  final Widget child;

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading> {
  Listenable? _shimmerChanges;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_shimmerChanges != null) {
      _shimmerChanges!.removeListener(_onShimmerChange);
    }
    _shimmerChanges = Shimmer.of(context)?.shimmerChanges;
    if (_shimmerChanges != null) {
      _shimmerChanges!.addListener(_onShimmerChange);
    }
  }

  @override
  void dispose() {
    _shimmerChanges?.removeListener(_onShimmerChange);
    super.dispose();
  }

  void _onShimmerChange() {
    if (widget.isLoading) {
      setState(() {
        // Update the shimmer painting.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isLoading) {
      return widget.child;
    }

    // Collect ancestor shimmer info.
    final shimmer = Shimmer.of(context)!;
    if (!shimmer.isSized) {
      // The ancestor Shimmer widget has not laid
      // itself out yet. Return an empty box.
      return const SizedBox();
    }
    final shimmerSize = shimmer.size;
    final gradient = shimmer.gradient;
    final offsetWithinShimmer = shimmer.getDescendantOffset(
      descendant: context.findRenderObject() as RenderBox,
    );

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return gradient.createShader(
          Rect.fromLTWH(
            -offsetWithinShimmer.dx,
            -offsetWithinShimmer.dy,
            shimmerSize.width,
            shimmerSize.height,
          ),
        );
      },
      child: widget.child,
    );
  }
}

class ShimmerMediaItem extends StatelessWidget {
  const ShimmerMediaItem({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: Colors.black,
        ),
      ),
    );
  }
}

class CardListItem extends StatelessWidget {
  const CardListItem({
    super.key,
    required this.isLoading,
  });

  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          buildText(isLoading),
        ],
      ),
    );
  }
}

Widget buildText(isLoading) {
  if (isLoading) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          width: 250,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ],
    );
  } else {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do '
        'eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      ),
    );
  }
}

Widget buildTopRowList() {
  return SizedBox(
    height: 240,
    child: ListView(
      physics: null,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      children: [
        const SizedBox(width: 16),
        buildTopRowItem(),
        buildTopRowItem(),
        buildTopRowItem(),
        buildTopRowItem(),
        buildTopRowItem(),
        buildTopRowItem(),
        buildTopRowItem(),
        buildTopRowItem(),
        buildTopRowItem(),
        buildTopRowItem(),
      ],
    ),
  );
}

Widget buildTopRowItem() {
  return const ShimmerLoading(
    isLoading: true,
    child: ShimmerMediaItem(),
  );
}

Widget buildListItem(isLoading) {
  return ShimmerLoading(
    isLoading: isLoading,
    child: CardListItem(
      isLoading: isLoading,
    ),
  );
}
