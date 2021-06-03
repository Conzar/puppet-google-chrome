# Google Chrome Puppet Module Changelog

## 2021-06-03

- Added a check on the /etc/opt file resource due to other classes needing to use this path.
  So now only creates the resource if it does not exist.

## 2021-01-21

- Added a new class for managing the policy settings.

## 2021-01-17

- Replace apt-key with file based key.
