todo-rg = "app-rg"
todo-vnet = {
  vn1 = {
    name          = "app-vnet"
    address_space = ["10.0.0.0/16"]
  }
}

todo-subnet = {
  sn1 = {
    name             = "subnet1-app"
    address_prefixes = ["10.0.1.0/24"]
  }
}

todo-nsg = {
  nsg1 = {
    name = "acceptanceTestSecurityGroup-todo"
  }
}

security_rule = {
  rule1 = {
    name                   = "Rule1"
    priority               = 100
    destination_port_range = "22"
  },
  rule2 = {
    name                   = "Rule2"
    priority               = 101
    destination_port_range = "80"
  }
}

nic-todo = {
  nic1 = {
    name = "n1c-todo1"

  }
}

ipconfig = {
  ipconfi1 = {
    name = "internal1"
  }
}

pip-todo = {
  pip1 = {
    name = "pip-todo"
  }
}

vm-todo = {
  vm1 = {
    name = "vm-app1"
  }
}