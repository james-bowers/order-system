workflow "Test & Check Formatting" {
  on = "push"
  resolves = ["Test", "Check Formatting"]
}

action "Start postgres" {
  uses = "actions/docker/cli@8cdf801b322af5f369e00d85e9cf3a7122f49108"
  args = "run -p 5432:5432 --name db-postgres postgres"
}

action "Get Dependencies" {
  uses = "james-bowers/actions/mix@master"
  needs = ["Start postgres"]
  args = "deps.get"
}

action "Test" {
  uses = "james-bowers/actions/mix@master"
  needs = ["Get Dependencies"]
  args = "test"
  env = {
    MIX_ENV = "test"
  }
}

action "Check Formatting" {
  uses = "james-bowers/actions/mix@master"
  args = "format --check-formatted"
}
