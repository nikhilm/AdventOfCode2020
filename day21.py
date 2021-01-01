"""Done using Python instead of Smalltalk to use the opportunity to learn a constraint solver."""
from dataclasses import dataclass
import sys
from typing import NewType, List, Set
import z3

Ingredient = NewType('Ingredient', str)
Allergen = NewType('Allergen', str)

@dataclass
class Food:
    allergens: Set[Allergen]
    ingredients: Set[Ingredient]

def parse_input(filename: str) -> List[Food]:
    foods = []
    for line in open(filename, 'r'):
        line = line.strip()
        paren_idx = line.find('(')
        if paren_idx == -1:
            ingredient_line = line
            allergen_line = ''
        else:
            ingredient_line = line[:paren_idx].strip()
            # Remove the last character ')' and '(contains '
            allergen_line = line[(paren_idx + 9):-1]
        ingredients = {ig.strip() for ig in ingredient_line.split(' ') if ig}
        allergens = {ag.strip() for ag in allergen_line.split(',') if ag}
        foods.append(Food(allergens, ingredients))
    return foods

def solve(foods: List[Food]):
    ingredients = {ig for food in foods for ig in food.ingredients}
    allergens = {ag for food in foods for ag in food.allergens}

    # Introduce all the variables, where each variable will be true if that ingredient contains that allergen.
    variables = {z3.Bool(f"{ig}_{ag}") for ig in ingredients for ag in allergens}

    equations = []

    # In a given food, for every allergen, one of the ingredients must have that allergen.
    # So at least one of the relations must be true.
    for food in foods:
        for allergen in food.allergens:
            equations.append(z3.Or(*[z3.Bool(f"{ingredient}_{allergen}") for ingredient in food.ingredients]))

    # An ingredient can have zero or one allergens.
    for ingredient in ingredients:
        equations.append(z3.Sum([z3.If(z3.Bool(f"{ingredient}_{allergen}"), 1, 0) for allergen in allergens]) <= 1)

    # An allergen is in exactly one ingredient.
    for allergen in allergens:
        equations.append(z3.Sum([z3.If(z3.Bool(f"{ingredient}_{allergen}"), 1, 0) for ingredient in ingredients]) == 1)

    solver = z3.Solver()
    solver.add(equations)
    solver.check()
    model = solver.model()

    # Determine which ingredients have which allergens, which means {ig}_{ag} is true.
    ingredients_with_allergens = {}
    for var in variables:
        if model.eval(var):
            ingredient, allergen = repr(var).split("_")
            ingredients_with_allergens[ingredient] = allergen

    print(ingredients_with_allergens)
    ingredients_without_allergens = ingredients.difference(set(ingredients_with_allergens.keys()))
    print(ingredients_without_allergens)
    count = 0
    for food in foods:
        for ingredient in ingredients_without_allergens:
            if ingredient in food.ingredients:
                count += 1

    # Assertions for our specific input.
    assert count == 2724
    print("Part 1", count)

    canonical_list = []
    allergens_to_ingredients = {ag: ig for ig, ag in ingredients_with_allergens.items()}
    allergens = sorted(allergens_to_ingredients.keys())
    for allergen in allergens:
        canonical_list.append(allergens_to_ingredients[allergen])

    canonical = ",".join(canonical_list)
    assert canonical == 'xlxknk,cskbmx,cjdmk,bmhn,jrmr,tzxcmr,fmgxh,fxzh'
    print("Part 2", canonical)

if __name__ == '__main__':
    foods = parse_input(sys.argv[1])
    solve(foods)
