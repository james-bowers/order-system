workflow "Test & Check Formatting" {
  on = "push"
  resolves = ["Test", "Check Formatting"]
}

action "Get Dependencies" {
  uses = "james-bowers/actions/mix@master"
  args = "deps.get"
}

action "Test" {
  uses = "james-bowers/actions/docker-compose@master"
  args = "run test"
}

action "Check Formatting" {
  uses = "james-bowers/actions/mix@master"
  args = "format --check-formatted"
}
