# Changelog

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
