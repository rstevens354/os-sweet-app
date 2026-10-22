/* This calculation allows you to set values against each of your domain types.
In this example we have taken the different types of crops and assigned various expected yield values*/
Decode($Feature.Type,'BAR',80, 'WHE', 70, 'SUG', 95, 'GRASS', 100, 'POTATO', 40, 100)