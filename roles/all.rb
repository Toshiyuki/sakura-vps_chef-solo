name "all"
description "for SAKURA Internet VPS Server"
run_list(
  "recipe[sshd]",
  "recipe[iptables]",
  "recipe[httpd]",
  "recipe[php]",
  "recipe[powerdns]",
  "recipe[wordpress]",
  "recipe[rcms]",
)

default_attributes({
  :role                => "all",
})
