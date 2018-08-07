# hello-world

[![Build Status](https://travis-ci.org/pbar1/hello-world.svg?branch=master)](https://travis-ci.org/pbar1/hello-world)

Hello world!

## Notes
Semantic Release deploys to GitHub releases on the _untagged_ commit. The immediate _tagged_ commit skips the GitHub deployment.

#### Output from an untagged commit/build
```
[semantic-release]: getting default branch...
[semantic-release]: found default branch: master
[semantic-release]: found current branch: master
[semantic-release]: found current sha: b51fe8773c1883b24fab5796201c41ee18ac5c79
[semantic-release]: running CI condition...
[condition-travis]: Success at attempt 1. All 1 jobs passed.
[semantic-release]: getting latest release...
[semantic-release]: found version: 1.0.0
[semantic-release]: getting commits...
[semantic-release]: calculating new version...
[semantic-release]: new version: 1.1.0
[semantic-release]: generating changelog...
[semantic-release]: creating release...
[semantic-release]: done.
```

#### Output from a tagged commit/build
```
[semantic-release]: getting default branch...
[semantic-release]: found default branch: master
[semantic-release]: found current branch: v1.1.0
[semantic-release]: found current sha: b51fe8773c1883b24fab5796201c41ee18ac5c79
[semantic-release]: running CI condition...
[semantic-release]: This test run was triggered by a git tag and therefore a new version won’t be published.
```
