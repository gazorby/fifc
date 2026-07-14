# Changelog

All notable changes to this project will be documented in this file.

## [0.2.1](https://github.com/gazorby/fifc/compare/v0.2.0..v0.2.1) - 2026-07-14

### ⚙️ Miscellaneous Tasks

- *(release)* Bump to v0.2.1 - ([f9311de](https://github.com/gazorby/fifc/commit/f9311deb7f32608eeb26f82b1411cb80ab4e2a00))
- Trigger cd after ci on tag - ([d6e5082](https://github.com/gazorby/fifc/commit/d6e508230f39ad68d751df737d5473ab14da77a4))

## New Contributors ❤️

* @github-actions[bot] made their first contribution
## [0.2.0](https://github.com/gazorby/fifc/compare/v0.1.1..v0.2.0) - 2026-07-14

### 🚀 Features

- Better fzf result navigation (#72) - ([397e171](https://github.com/gazorby/fifc/commit/397e171edbdc460e49f1c3cb5ac5cefe0e165e3b))

### 🐛 Bug Fixes

- *(fifc)* Fix command not found in preview - ([8ef00c6](https://github.com/gazorby/fifc/commit/8ef00c6d849dd54642113e5747e1f689e29370ed))
- Don't escape environment variable in completion - ([457cec0](https://github.com/gazorby/fifc/commit/457cec0bbdcc93d884729e7ccd2dc82a94caee59))
- Variables will die in fzf's fish, no erase needed - ([6681b51](https://github.com/gazorby/fifc/commit/6681b51d1a5e82eb87a919448a495dba49932bb6))
- Rule initialization - ([a01650c](https://github.com/gazorby/fifc/commit/a01650cd432becdc6e36feeff5e8d657bd7ee84a))
- Remove extra tab binding (#61) - ([5f3f5a8](https://github.com/gazorby/fifc/commit/5f3f5a8a96670fac032a923de7ec1602a132b31c))

### 💼 Other

- *(deps)* Update actions/checkout action to v7 (#66) - ([0116e92](https://github.com/gazorby/fifc/commit/0116e92e6f0b232939453c0a704df5c03f0edeb9))
- *(deps)* Update fish-shop/install-plugin action to v2 (#67) - ([16bf41d](https://github.com/gazorby/fifc/commit/16bf41d0f81578f74dcc5a09f89a5b58863a80ed))
- *(deps)* Update fish-shop/run-fishtape-tests action to v2 (#68) - ([4ca440f](https://github.com/gazorby/fifc/commit/4ca440f4a76f9fc8106945f56dd08cf2c22011ce))
- Replace exa with eza (#70) - ([220dbdc](https://github.com/gazorby/fifc/commit/220dbdc15352f67d6ad0bdf2175a280e186ca047))

### 📚 Documentation

- *(readme)* Update - ([2ee5bee](https://github.com/gazorby/fifc/commit/2ee5beec7dfd28101026357633616a211fe240ae))
- Update readme - ([58aaa95](https://github.com/gazorby/fifc/commit/58aaa95d038f157180f831fce2afdec5179f843e))

### ⚡ Performance

- *(startup)* Skip load of fifc rules when in interactive shell - ([64433fa](https://github.com/gazorby/fifc/commit/64433fa58b7d102f18eb2160d52ef706296cb585))

### 🎨 Styling

- Run prettier - ([8bd370c](https://github.com/gazorby/fifc/commit/8bd370c4a5db3b71f52a3079b758f0f2ed082044))

### ⚙️ Miscellaneous Tasks

- *(bump)* Add an empty requirement.txt because pip cache in bumpversion action need some - ([4d444c3](https://github.com/gazorby/fifc/commit/4d444c357d1a870c21a88437396dddf6841027ea))
- *(mise)* Add task to install fish plugin from the current folder - ([5a664da](https://github.com/gazorby/fifc/commit/5a664da968ff0a8abf2563e17abc74ea34aa5e8a))
- *(release)* Bump to v0.2.0 - ([c0f97d7](https://github.com/gazorby/fifc/commit/c0f97d73eec25d6733bfae7172e10b703c461d94))
- Add mise for ci and local development (#63) - ([2d552aa](https://github.com/gazorby/fifc/commit/2d552aa8aaf683df1fabe495da58b59bf47805d9))
- Add renovate (#64) - ([1b14313](https://github.com/gazorby/fifc/commit/1b143133bbf117b003f49d5cefd29c72298a924b))
- Add CLAUDE.md - ([6b37932](https://github.com/gazorby/fifc/commit/6b37932e94d6d0e398cdbc6e1b28cc3d5e27afce))
- Use fish-shop/install-fish-shell (#69) - ([ab119b8](https://github.com/gazorby/fifc/commit/ab119b818fa37851311794f35f1fda5ed8781c74))
- Add git-cliff (#74) - ([41c355e](https://github.com/gazorby/fifc/commit/41c355ecedcf78d3edc41e035a52c303c0340711))
- Add bumpversion config - ([eaa527f](https://github.com/gazorby/fifc/commit/eaa527fd822396edc7b9748bddebba33c59ac9d2))
- Add an empty requirementx.txt as a workaround for bumpversion - ([ea1cab4](https://github.com/gazorby/fifc/commit/ea1cab421a6c61365cef68fe48fd99938cbd5dd9))

## New Contributors ❤️

* @justbispo made their first contribution in [#60](https://github.com/gazorby/fifc/pull/60)
* @ollehu made their first contribution in [#49](https://github.com/gazorby/fifc/pull/49)
* @renovate[bot] made their first contribution in [#68](https://github.com/gazorby/fifc/pull/68)
* @HydroH made their first contribution in [#52](https://github.com/gazorby/fifc/pull/52)
* @PiasekDev made their first contribution in [#61](https://github.com/gazorby/fifc/pull/61)
* @simonm made their first contribution in [#62](https://github.com/gazorby/fifc/pull/62)
* @phanen made their first contribution
* @Zh40Le1ZOOB made their first contribution
## [0.1.1](https://github.com/gazorby/fifc/compare/v0.1.0..v0.1.1) - 2023-03-05

### 🐛 Bug Fixes

- *(directories)* Escape name with spaces instead of quoting them - ([1dcd4e6](https://github.com/gazorby/fifc/commit/1dcd4e6ec019c8ea48123fc7c217663f79b8633d))

### ⚡ Performance

- Improve completion group determination - ([bfba36f](https://github.com/gazorby/fifc/commit/bfba36f8e0afd1423b2ac1a7562824ad54ea1fd7))

## [0.1.0](https://github.com/gazorby/fifc/releases/tag/v0.1.0) - 2023-01-23

### 🚀 Features

- Use `$EDITOR` as default editor - ([8da1d3a](https://github.com/gazorby/fifc/commit/8da1d3af9f7929b0f743ebf8403a0a458b514cc3))

## New Contributors ❤️

* @gazorby made their first contribution in [#25](https://github.com/gazorby/fifc/pull/25)
* @kidonng made their first contribution
<!-- generated by git-cliff -->
