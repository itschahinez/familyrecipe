// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import DropdownController from "./dropdown_controller"
application.register("dropdown", DropdownController)

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import InsertRecipeImageController from "./insert_recipe_image_controller"
application.register("insert-recipe-image", InsertRecipeImageController)

import SearchController from "./search_controller"
application.register("search", SearchController)

import { Autocomplete } from 'stimulus-autocomplete'
application.register('autocomplete', Autocomplete)
