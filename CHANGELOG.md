# Change log

## Version 0.1.9 (Oct 12, 2016)

Minor enhancements:
  * Updated logrotate configuration
  * Bump up gem dependency of Luban to version 0.9.0

## Version 0.1.8 (Sept 28, 2016)

Minor enhancements:
  * Applied subcommand grouping for better clarity
    * As a result, bump up gem dependency of Luban to version 0.8.8

## Version 0.1.7 (Sept 19, 2016)

Minor enhancements:
  * Refactored the way of composing shell commands
    * As a result, bumped up the gem dependency on Luban to version 0.8.0

## Version 0.1.6 (Aug 05, 2016)

Bug fixes:
  * Changed mechanism for adding default templates path in order to handle templates paths inheritance
    * As a result, updated gem dependency on Luban to version 0.6.8

## Version 0.1.5 (Jul 27, 2016)

Bug fixes:
  * Refactored #default_templates_path to fix an inheritance issue

## Version 0.1.4 (Jul 11, 2016)

Minor enhancements:
  * Changed monit reboot mode to laststate

## Version 0.1.3 (Jul 08, 2016)

Minor enhancements:
  * Refactored method #default_templates_path in a DRY way
  * Added gem dependency for Luban with version 0.6.0 or above

## Version 0.1.2 (Jun 17, 2016)

Bug fixes:
  * Fixed process matching pattern to grep the correct service process

## Version 0.1.1 (Jun 17, 2016)

Bug fixes:
  * Corrected the package major version

## Version 0.1.0 (Jun 16, 2016)

New features:
  * Initialized Luban deployemnt package of Mysql
