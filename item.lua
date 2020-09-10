local invinci_armor = table.deepcopy(data.raw["armor"]["heavy-armor"])

invinci_armor.lastDir = 1
invinci_armor.name = "invinci_armor"
invinci_armor.icons= {
  {
    icon=invinci_armor.icon,
    tint={r=1,g=1,b=1,a=.5}
  },
}

invinci_armor.resistances = {
  {
    type = "physical",
    decrease = 0,
    percent = 100
  },
  {
    type = "explosion",
    decrease = 0,
    percent = 100
  },
  {
    type = "acid",
    decrease = 0,
    percent = 100
  },
  {
    type = "fire",
    decrease = 0,
    percent = 100
  }
}




local recipe = table.deepcopy(data.raw["recipe"]["heavy-armor"])
recipe.enabled = true
recipe.name = "invinci_armor"
recipe.category = "crafting-with-fluid"
recipe.ingredients = {{"copper-plate",2000},{"steel-plate",500},{type='fluid', name='water', amount=1000, fluidbox_index=1}}
recipe.result = "invinci_armor"

data:extend{invinci_armor,recipe}