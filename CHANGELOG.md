# Changelog

## [3.2.0](https://github.com/PeterMosmans/gitlab-demolab/compare/3.1.0...3.2.0) (2025-08-28)


### Features

* add option to remove services and volumes ([0878973](https://github.com/PeterMosmans/gitlab-demolab/commit/087897353138ddb5b3064654f4b35cd73942e81e))
* automatically update scripts to latest version ([8676781](https://github.com/PeterMosmans/gitlab-demolab/commit/8676781605a4869618b2f989e36f358d22133d50))
* bump version numbers ([bb6c591](https://github.com/PeterMosmans/gitlab-demolab/commit/bb6c59178f22178b685afb6a7a6f3659449a9a6c))
* bump versions of service images ([37076db](https://github.com/PeterMosmans/gitlab-demolab/commit/37076db77616174da7b9d4c1626dc34b369a05ac))
* bump versions of several used images ([bd7601c](https://github.com/PeterMosmans/gitlab-demolab/commit/bd7601ca2dce3c27b57e8f86fad9821da93d9ba9))
* bump versions to verified latest ones ([0c0410f](https://github.com/PeterMosmans/gitlab-demolab/commit/0c0410f5015cfd4044228f3894f23dd90bc26a7c))
* clean up temporary files after use ([8abf1d0](https://github.com/PeterMosmans/gitlab-demolab/commit/8abf1d0bb47b1072787e8d23b8ce5fb6590a8a3e))
* remove deprecated values ([dd38154](https://github.com/PeterMosmans/gitlab-demolab/commit/dd38154d939ae7fa35236c234e99269318cb32a9))
* suppress status messages and extend time-out ([490471e](https://github.com/PeterMosmans/gitlab-demolab/commit/490471e6a2e9868eaac976978cc5c9a29159b378))
* update automated security testing tool images ([6943d45](https://github.com/PeterMosmans/gitlab-demolab/commit/6943d458d4395a8ebf269ff7db1362483e4a0354))
* update checker now scans all gitlab-ci.yml files ([4dd8084](https://github.com/PeterMosmans/gitlab-demolab/commit/4dd80843ad306f62c03618c4eb7e88a529c737c3))
* update default automated security testing tool images ([18da7c1](https://github.com/PeterMosmans/gitlab-demolab/commit/18da7c10176e639ebbc4c52bbd691415e3c1a038))
* update plugins ([7881a38](https://github.com/PeterMosmans/gitlab-demolab/commit/7881a38d74bc0a29e4cfb1ba02ed2cae9e4031d0))
* update various images ([a39db94](https://github.com/PeterMosmans/gitlab-demolab/commit/a39db946db6f3ec6695b4a93d90abebc82b0de17))
* update versions ([27a2655](https://github.com/PeterMosmans/gitlab-demolab/commit/27a2655a13ae978b085f33843a21255fac23c010))
* update versions with latest tested ones ([d79ca36](https://github.com/PeterMosmans/gitlab-demolab/commit/d79ca36a4a38bd11f68e9e28f7cf1a2d4d231550))
* use updated ZAP Docker repository ([b1f90ee](https://github.com/PeterMosmans/gitlab-demolab/commit/b1f90ee318246169cb254683c965bca59e4605d8))
* workaround for curl not being able to resolve docker hosts ([cccf800](https://github.com/PeterMosmans/gitlab-demolab/commit/cccf8002517df6d09713099e1bb3fd62a9e999ff))


### Bug Fixes

* ensure repository is ready to be linted for first run ([1110d79](https://github.com/PeterMosmans/gitlab-demolab/commit/1110d796e529d908e00ed8bc92d24891002a8da1))
* ensure that first Hadolint run always continues ([93037ad](https://github.com/PeterMosmans/gitlab-demolab/commit/93037ad5b390e11a1697de893e626caa017c4d93))
* use IPv4 for curl ([11996de](https://github.com/PeterMosmans/gitlab-demolab/commit/11996dea938110fffe2bae28856057d67de462be))
* use wget instead of curl for newer SonarQube images ([6d9b834](https://github.com/PeterMosmans/gitlab-demolab/commit/6d9b8341321ca33bb1a504fbc8c8c7d8bbaa60c7))

## [3.1.0](https://github.com/PeterMosmans/gitlab-demolab/compare/3.0.0...3.1.0) (2024-03-14)


### Features

* use consistent messaging while starting up ([a4bbe3f](https://github.com/PeterMosmans/gitlab-demolab/commit/a4bbe3f0dbee15d87d0faa6503635e69e637d3ac))


### Bug Fixes

* ensure that checkout for detect-secrets is not ambiguous ([cc85679](https://github.com/PeterMosmans/gitlab-demolab/commit/cc8567998ccc0b034216280012fee324f2a79ebb))
* move Trivy pipeline script to correct directory ([cd45488](https://github.com/PeterMosmans/gitlab-demolab/commit/cd45488b26dc72ea1ed29f103e70e47c2063264b))
* use Dependency-Track during subsequent tests ([aac6e2d](https://github.com/PeterMosmans/gitlab-demolab/commit/aac6e2da3dc911db8aa553c0a86b451c1e5dd8b1))

## [3.0.0](https://github.com/PeterMosmans/gitlab-demolab/compare/2.1.0...3.0.0) (2024-03-10)


### Features

* add demonstration pipeline scripts ([e2b8757](https://github.com/PeterMosmans/gitlab-demolab/commit/e2b8757625491123b3d5144b06ae5dfc9889e88a))
* add helper script to check whether images are up-to-date ([99e38d6](https://github.com/PeterMosmans/gitlab-demolab/commit/99e38d649c2cbd13fa38ef884d9772fbfbfd85d9))
* add warning when curl is not installed ([0e0ab70](https://github.com/PeterMosmans/gitlab-demolab/commit/0e0ab708f1ead9c792dc348018d1a3944c5d2e04))
* check version of gofwd/tools-image ([8f3812e](https://github.com/PeterMosmans/gitlab-demolab/commit/8f3812e34efe5640f18a3e6c08d3697e70f66e4c))
* improve and colorize installer script ([6bb4c6c](https://github.com/PeterMosmans/gitlab-demolab/commit/6bb4c6c5143fc0a2dcbfe54e02d1815244ac2938))
* improve initial configuration of SonarQube and Dependency-Track ([16d962d](https://github.com/PeterMosmans/gitlab-demolab/commit/16d962d0dc7ddbcd1c95c4476a53182929a6aa8e))
* update default version of tools ([97db81a](https://github.com/PeterMosmans/gitlab-demolab/commit/97db81a97f9116835cc69bef8e19efa661ed24eb))
* update defaults ([8953898](https://github.com/PeterMosmans/gitlab-demolab/commit/895389870dd526910ee11dcdb7ddfd19906cc9ed))
* use correct image for Docker in Docker ([bd69cd5](https://github.com/PeterMosmans/gitlab-demolab/commit/bd69cd5e8af7517f4293350d25ed02d24dba9e87))
* use faster Docker-in-docker driver by default ([eefd288](https://github.com/PeterMosmans/gitlab-demolab/commit/eefd288b32688a95d649f636e6163702b8be1590))


### Bug Fixes

* correct spelling error ([3beb41c](https://github.com/PeterMosmans/gitlab-demolab/commit/3beb41cb318165dba2baefbefb479ff95f786bd2))

## [2.1.0](https://github.com/PeterMosmans/gitlab-demolab/compare/2.0.0...2.1.0) (2024-02-02)


### Features

* add Dependency-Track Docker images ([aab412a](https://github.com/PeterMosmans/gitlab-demolab/commit/aab412a898bf3d4ccc575a3b2305162075f64496))
* add Dependency-Track variables ([e6384dc](https://github.com/PeterMosmans/gitlab-demolab/commit/e6384dcca37e56bd2f827122d338b26644987b56))
* parameterize extra shared Runner volume ([39596b5](https://github.com/PeterMosmans/gitlab-demolab/commit/39596b52e06baf1499be7735b718cc597c2f98e6))
* split out startup of services in installation file ([887676e](https://github.com/PeterMosmans/gitlab-demolab/commit/887676e072149e3d26ba52258e4b9e6aea1da45d))
* support shared Runner caches ([5c78706](https://github.com/PeterMosmans/gitlab-demolab/commit/5c78706f05c1d7decd1730f3c6b71a5862e6ad60))
* update GitLab version ([f2430df](https://github.com/PeterMosmans/gitlab-demolab/commit/f2430dfa9d0a1e233362e526012966072c0ebc59))
* update versions and add SonarQube plugins ([b8e0524](https://github.com/PeterMosmans/gitlab-demolab/commit/b8e0524a9f325f808f2402f065ac716afdce93aa))
* use named cache volume for runners ([4d3a351](https://github.com/PeterMosmans/gitlab-demolab/commit/4d3a351ff371a31e0686507210b27cc878aaa19a))
* use two runners with shared cache instead of three ([41b335e](https://github.com/PeterMosmans/gitlab-demolab/commit/41b335e3ab59ae481f6a7b0745afa84f90720837))


### Bug Fixes

* ensure that gitlab service name is being used for registration ([ecedc2e](https://github.com/PeterMosmans/gitlab-demolab/commit/ecedc2ed893d678962542ce5971275b8bb3edb7f))
* only configure SonarQube during the first run ([8b26e4a](https://github.com/PeterMosmans/gitlab-demolab/commit/8b26e4a9308647114c72abc1bc1a01f8862adcc3))

## [2.0.0](https://github.com/PeterMosmans/gitlab-demolab/compare/1.6.0...2.0.0) (2024-01-17)


### ⚠ BREAKING CHANGES

* check whether hostname can be resolved

### Features

* automatically use supplied env-example file ([9163f41](https://github.com/PeterMosmans/gitlab-demolab/commit/9163f41b5698d15dcdb13f57f4ead3acacaff8ae))
* be more verbose when resolving hosts ([e99e22f](https://github.com/PeterMosmans/gitlab-demolab/commit/e99e22fe73e807a01281f45e9a221cca2fc4999a))
* check whether hostname can be resolved ([408a737](https://github.com/PeterMosmans/gitlab-demolab/commit/408a737000196cd653204d4ea8342fead1a5fc72))
* update gitlab version tag ([915d8d4](https://github.com/PeterMosmans/gitlab-demolab/commit/915d8d4caf5fd99c30ca48c8725079559f59e56a))
* update versions ([fe3b5be](https://github.com/PeterMosmans/gitlab-demolab/commit/fe3b5be03f2d3c213e011b238d1ef4a5abf5cb72))
* update versions and use localhost by default ([bd18a70](https://github.com/PeterMosmans/gitlab-demolab/commit/bd18a708171360920587c8df8b04877a9d5d95b4))


### Bug Fixes

* pass correct variables to gitlab runner ([c99b753](https://github.com/PeterMosmans/gitlab-demolab/commit/c99b75398c9f9ded64af956f6a153d342a3cc483))

## [1.6.0](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/compare/1.5.0...1.6.0) (2023-10-25)


### Features

* add script to register runners using a runner token ([6ee389a](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/6ee389a1cc051c845f832bc49640be699081c849))
* remove auto registration token and scripts ([c008191](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/c00819149c3307e8399214e311d3900b005f16da))
* rename runners and configuration volumes ([aceba3c](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/aceba3cd2ad487f43f721ebdb74e0cfe493ad3c2))
* update versions of Docker images ([aaff903](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/aaff9035429fe091363f1314d86e6e0184dc1772))

## [1.5.0](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/compare/1.4.1...1.5.0) (2023-08-03)


### Features

* bind separate volume by default ([3dbe42e](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/3dbe42ecf69f42b0d377ded8e66676ba4372ffc9))
* display password when installlation finishes ([c5d98e4](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/c5d98e4e49a073ca26970b1fe342c0a63c8e131f))
* make network name variable ([5e364a4](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/5e364a4375e1ed519ac8ffb1dc5de10cb08237cc))
* only bind to localhost by default ([a29e95f](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/a29e95fe69cb7c122ed398b2830bc9783d202e29))

## [1.4.1](https://github.com/PeterMosmans/gitlab-demolab/compare/1.4.0...1.4.1) (2023-07-25)

## [1.4.0](https://github.com/PeterMosmans/gitlab-demolab/compare/1.3.0...1.4.0) (2023-05-31)

### Features

* add installer script to start up demo lab ([3e3a636](https://github.com/PeterMosmans/gitlab-demolab/commit/3e3a636243d90bb29a276735fa169521906e94a4))
* update default variables with new versions ([6980dd0](https://github.com/PeterMosmans/gitlab-demolab/commit/6980dd054469578b87dabcca07b4a0aa7d104feb))

## [1.3.0](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/compare/1.2.0...1.3.0) (2022-11-17)

### Features

- parameterize SonarQube image
  ([46ec3dd](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/46ec3dd415f9840a965174598b644994db25ec7d))

## [1.2.0](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/compare/1.1.0...1.2.0) (2022-07-14)

### Features

- add SonarQube as well as multiple runners
  ([0d6cbd3](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/0d6cbd3ca6d77f4f8e5a7f661f82cf66250fb74e))
- always use latest version of gitlab runner
  ([567b7f1](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/567b7f1398d6682f92827a7059fac7fb333438d4))
- ensure that register script can be used on any runner
  ([55ea69f](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/55ea69fd2039cb3d08f7e7f6c3ca1de196becaa3))
- ensure that uploaded artifacts can be any size
  ([2b3dd7a](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/2b3dd7ada12d8c5f55da32aaf2522418021c622b))
- update versions
  ([7a0473f](https://git.go-forward.net/PeterMosmans/gitlab-demolab/-/commit/7a0473faf6bcca966925f5f452cb6e62309a9c39))

## [1.1.0](https://github.com/PeterMosmans/gitlab-demolab/compare/1.0.0...1.1.0) (2022-04-12)

### Features

- ensure that GitLab version is parameterized
  ([7ed3785](https://github.com/PeterMosmans/gitlab-demolab/commit/7ed3785a5d97b57f3625cae1cd8c7e3bebddb0b7))

## 1.0.0 (2022-02-11)

### Features

- initial version
  ([28fc0ac](https://github.com/PeterMosmans/gitlab-demolab/commit/28fc0acadf3d0766b8b822e3ebf986532a29c386))
