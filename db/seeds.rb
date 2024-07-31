if User.all.empty?
  User.create(id: -1, account: "AMASSYS", password: "49d46c35",
              name: "AMASsys", state: "system")
  User.create(id: -2, account: "AMASUSER", password: "49d46c35",
              name: "AMASuser", state: "system")
end
