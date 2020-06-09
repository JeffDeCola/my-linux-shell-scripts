# my-linux-shell-scripts

[![Issue Count](https://codeclimate.com/github/JeffDeCola/my-linux-shell-scripts/badges/issue_count.svg)](https://codeclimate.com/github/JeffDeCola/my-linux-shell-scripts/issues)
[![License](http://img.shields.io/:license-mit-blue.svg)](http://jeffdecola.mit-license.org)

_A place to keep useful tools I created in go._

[GitHub Webpage](https://jeffdecola.github.io/my-linux-shell-scripts/)

## USEFUL TOOLS I CREATED

* [get-software-versions](https://github.com/JeffDeCola/my-linux-shell-scripts/tree/master/get-software-versions)

  _Get various linux software versions on your rig._

## UPDATE GITHUB WEBPAGE USING CONCOURSE (OPTIONAL)

For fun, I use concourse to update
[my-linux-shell-scripts GitHub Webpage](https://jeffdecola.github.io/my-linux-shell-scripts/)
and alert me of the changes via repo status and slack.

A pipeline file [pipeline.yml](https://github.com/JeffDeCola/my-linux-shell-scripts/tree/master/ci/pipeline.yml)
shows the entire ci flow. Visually, it looks like,

![IMAGE - my-linux-shell-scripts concourse ci pipeline - IMAGE](docs/pics/my-linux-shell-scripts-pipeline.jpg)

The `jobs` and `tasks` are,

* `job-readme-github-pages` runs task
  [readme-github-pages.sh](https://github.com/JeffDeCola/my-linux-shell-scripts/tree/master/ci/scripts/readme-github-pages.sh).

The concourse `resources types` are,

* `my-linux-shell-scripts` uses a resource type
  [docker-image](https://hub.docker.com/r/concourse/git-resource/)
  to PULL a repo from github.
* `resource-slack-alert` uses a resource type
  [docker image](https://hub.docker.com/r/cfcommunity/slack-notification-resource)
  that will notify slack on your progress.
* `resource-repo-status` uses a resource type
  [docker image](https://hub.docker.com/r/dpb587/github-status-resource)
  that will update your git status for that particular commit.

For more information on using concourse for continuous integration,
refer to my cheat sheet on [concourse](https://github.com/JeffDeCola/my-cheat-sheets/tree/master/software/operations-tools/continuous-integration-continuous-deployment/concourse-cheat-sheet).
