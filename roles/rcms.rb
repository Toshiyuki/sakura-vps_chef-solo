name "rcms"
description "rcms for SAKURA Internet VPS Server"
run_list(
  "recipe[sshd]",
  "recipe[iptables]",
  "recipe[rcms]",
  "recipe[postgresql]",
  "recipe[phantomjs]",
)

default_attributes({
  :role                => "rcms",
})
