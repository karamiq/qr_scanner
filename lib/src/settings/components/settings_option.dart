import 'package:app/common_lib.dart';
import 'package:flutter/material.dart';
import '../../../theme/app_colors.dart';

class SettingsOption extends StatefulWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final Color backgroundColor;
  final Color innerBackgroundColor;
  final void Function()? onTap;
  final void Function(bool)? onChange;
  final bool? switchValueFuture;
  final bool useSwitch;

  const SettingsOption({
    super.key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    this.backgroundColor = AppColors.primary,
    this.innerBackgroundColor = AppColors.backgroundLight,
    this.onTap,
    this.onChange,
    this.switchValueFuture,
    this.useSwitch = false,
  });

  @override
  State<SettingsOption> createState() => _SettingsOptionState();
}

class _SettingsOptionState extends State<SettingsOption> {
  bool currentSwitchValue = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchSwitchValue();
  }

  Future<void> _fetchSwitchValue() async {
    if (widget.onChange != null) {
      try {
        bool switchValue = widget.switchValueFuture!;
        setState(() {
          currentSwitchValue = switchValue;
          isLoading = false;
        });
      } catch (e) {}
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!widget.useSwitch && widget.onTap != null) {
          widget.onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 2),
        decoration: BoxDecoration(
          color: widget.backgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: widget.innerBackgroundColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
              leading: SvgPicture.asset(
                widget.iconPath,
                height: 25,
                color: AppColors.primary,
              ),
              title: Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  // fontFamily: GoogleFonts.roboto().fontFamily,
                ),
              ),
              subtitle: Text(
                widget.subtitle,
                style: const TextStyle(
                    //   fontFamily: GoogleFonts.roboto().fontFamily,
                    ),
              ),
              trailing: isLoading
                  ? const CircularProgressIndicator()
                  : widget.useSwitch
                      ? Switch.adaptive(
                          value: currentSwitchValue,
                          activeColor: widget.backgroundColor,
                          onChanged: (bool value) {
                            setState(() => currentSwitchValue = value);
                            if (widget.onChange != null) widget.onChange!(value);
                          },
                        )
                      : null),
        ),
      ),
    );
  }
}
