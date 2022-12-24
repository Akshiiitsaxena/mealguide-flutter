class Diet {
  final String name;
  final String id;
  final List<String> showcaseRecipes;

  Diet({
    required this.id,
    required this.name,
    required this.showcaseRecipes,
  });

  factory Diet.fromDoc(Map<String, dynamic> doc) {
    List<String> docShowcase = [];

    doc['showcase_recipe_ids'].forEach((val) {
      docShowcase.add(val);
    });

    return Diet(
      id: doc['id'],
      name: doc['name'],
      showcaseRecipes: docShowcase,
    );
  }

  get getImage {
    switch (name) {
      case 'Vegetarian':
        return 'assets/plates/vegetarian_plate.png';
      case 'Low Carb':
        return 'assets/plates/low_carb_plate.png';
      case 'Mediterranean':
        return 'assets/plates/mediterranean_plate.png';
      case 'Keto':
        return 'assets/plates/keto_plate.png';
      case 'Diabetes Friendly':
        return 'assets/plates/diabetes_friendly_plate.png';
      case 'DASH':
        return 'assets/plates/dash_plate.png';
      case 'Paleo':
        return 'assets/plates/paleo_plate.png';
      case 'Vegan':
        return 'assets/plates/vegen_plate.png';
      case 'High Protein':
        return 'assets/plates/high_protein_plate.png';
      case 'Balanced Diet':
        return 'assets/plates/balanced_plate.png';
      case 'PCOD':
        return 'assets/plates/pcod_plate.png';
      case 'Gluten Free':
        return 'assets/plates/gluten_free_plate.png';
      case 'Intermittent Fasting':
        return 'assets/plates/if_plate.png';
      default:
    }
  }

  get getDisplayName {
    switch (name) {
      case 'Balanced Diet':
        return 'Balanced Plan';
      case 'Intermittent Fasting':
        return 'Intermittent Fasting';
      default:
        return '$name Diet';
    }
  }

  String get getShortDescription {
    switch (name) {
      case 'Vegetarian':
        return "The vegetarian diet involves abstaining from eating meat, fish and poultry.";
      case 'Low Carb':
        return "A low-carb diet is a diet that restricts carbohydrates, such as those found in sugary foods, pasta and bread.";
      case 'Mediterranean':
        return "The Mediterranean diet is based on the traditional foods that people used to eat in countries like Italy and Greece back in 1960.";
      case 'Keto':
        return "The ketogenic diet is a very low carb, high fat diet that shares many similarities with the Atkins and low carb diets.";
      case 'Diabetes Friendly':
        return "Focus on eating lean protein, high-fiber, less processed carbs, fruits, and vegetables, low-fat dairy.";
      case 'DASH':
        return "The DASH plan was originally developed to help treat or prevent high blood pressure (hypertension), but this diet may also reduce the risk of other diseases, including diabetes.";
      case 'Paleo':
        return "The paleo diet is designed to resemble what human hunter-gatherer ancestors ate thousands of years ago.";
      case 'Vegan':
        return "The vegan diet is devoid of all animal products, including meat, eggs and dairy.";
      case 'High Protein':
        return "A high-protein diet is easy to follow and can be customized according to your own food preferences and health-related goals.";
      case 'Balanced Diet':
        return "A balanced diet supplies the nutrients your body needs to work effectively.";
      case 'PCOD':
        return "Polycystic ovary syndrome (PCOS) is a condition that affects a woman’s hormone levels. Following a diet that meets a person’s nutritional needs, maintains a healthy weight, and promotes good insulin levels can help people with PCOS feel better.";
      case 'Gluten Free':
        return "A gluten-free diet is when foods like wheat, rye and barley etc are excluded because they contain the protein - gluten.";
      case 'Intermittent Fasting':
        return "It is an eating pattern where you cycle between periods of eating and fasting. It does not say anything about which foods to eat, but rather when you should eat them.";
      default:
        return '';
    }
  }

  String get getLongDescription {
    switch (name) {
      case 'Vegetarian':
        return "Vegetarianism is the practice of abstaining from the consumption of meat, and may also include abstention from by-products of animal slaughter.\n\nThe vegetarian diet involves abstaining from eating meat, fish and poultry.";
      case 'Low Carb':
        return "A low-carb diet is a diet that restricts carbohydrates, such as those found in sugary foods, pasta and bread.\n\nIt is high in protein, fat and healthy vegetables.\n\nThere are many different types of low-carb diets, and studies show that they can cause weight loss and improve health.";
      case 'Mediterranean':
        return "The Mediterranean diet is based on the traditional foods that people used to eat in countries like Italy and Greece back in 1960.\n\nNumerous studies have now shown that the Mediterranean diet can cause weight loss and help prevent heart attacks, strokes, type 2 diabetes and premature death.";
      case 'Keto':
        return "The ketogenic diet is a very low carb, high fat diet that shares many similarities with the Atkins and low carb diets.\n\nIt involves drastically reducing carbohydrate intake and replacing it with fat.\n\nThis reduction in carbs puts your body into a metabolic state called ketosis.\n\nWhen this happens, your body becomes incredibly efficient at burning fat for energy.\n\nIt also turns fat into ketones in the liver, which can supply energy for the brain.\n\nKetogenic diets can cause significant reductions in blood sugar and insulin levels.";
      case 'Diabetes Friendly':
        return "If you have diabetes, you should focus on eating lean protein, high-fiber, less processed carbs, fruits, and vegetables, low-fat dairy, and healthy vegetable-based fats such as avocado, nuts, canola oil, or olive oil.\n\nYou should also manage your carbohydrate intake.\n\nGenerally, women should aim for about 45 grams of carb per meal while men should aim for 60. Ideally, these would come from complex carbs, fruits, and vegetables.";
      case 'DASH':
        return "The DASH plan was originally developed to help treat or prevent high blood pressure (hypertension), but this diet may also reduce the risk of other diseases, including diabetes.\n\nIt may have the additional benefit of helping you lose weight.\n\nPeople following the DASH plan are encouraged to reduce portion sizes and eat foods rich in blood pressure-lowering nutrients, such as potassium, calcium, and magnesium.";
      case 'Paleo':
        return "The paleo diet is designed to resemble what human hunter-gatherer ancestors ate thousands of years ago.\n\nBy following a whole food-based diet and leading physically active lives, hunter-gatherers presumably had much lower rates of lifestyle diseases, such as obesity, diabetes and heart disease.\n\nSeveral studies suggest that Paleo diet can lead to significant weight loss (without calorie counting) and major improvements in health.";
      case 'Vegan':
        return "Veganism is defined as a way of living that attempts to exclude all forms of animal exploitation and cruelty, whether for food, clothing or any other purpose.\n\nFor these reasons, the vegan diet is devoid of all animal products, including meat, eggs and dairy.\n\nBy following a vegan diet, people experience many health benefits like a reduced chance of certain types of Cancer and heart disease, weight loss and better management of diabetes etc.";
      case 'High Protein':
        return "A high-protein diet is easy to follow and can be customized according to your own food preferences and health-related goals.\n\nFor instance, you may want to follow a low-carb, high-protein diet to keep your blood sugar under control.\n\nIf you avoid milk products, you can follow a dairy-free diet that is rich in protein.\n\nEven a vegetarian diet can be high in protein if it includes eggs or dairy and plenty of legumes and other plant proteins.";
      case 'Balanced Diet':
        return "A balanced diet supplies the nutrients your body needs to work effectively.\n\nWithout balanced nutrition, your body is more prone to disease, infection, fatigue, and low performance.";
      case 'PCOD':
        return "Polycystic ovary syndrome (PCOS) is a condition that affects a woman’s hormone levels.\n\nWomen with PCOS produce higher-than-normal amounts of male hormones.\n\nThis hormone imbalance causes them to skip menstrual periods, creates cysts in their ovaries and makes it harder for them to get pregnant.\n\nTwo of the primary ways that diet affects PCOS are weight management and insulin production and resistance.\n\nUp to 70% of women with PCOS have insulin resistance and thus insulin plays a significant role in PCOS.\n\nManaging insulin levels with a PCOS diet is one of the best steps people can take to manage the condition.\n\nFollowing a diet that meets a person’s nutritional needs, maintains a healthy weight, and promotes good insulin levels can help people with PCOS feel better.";
      case 'Gluten Free':
        return "A gluten-free diet is when foods like wheat, rye and barley etc are excluded because they contain the protein - gluten.\n\nMost studies on gluten-free diets have been done on people with celiac disease, but there is another condition called gluten sensitivity that also causes problems with gluten.\n\nIf you are intolerant to gluten, then you need to avoid it completely.\n\nIf not, you will experience severe discomfort and adverse health effects.";
      case 'Intermittent Fasting':
        return "Intermittent fasting is an eating pattern where you cycle between periods of eating and fasting.\n\nIt does not say anything about which foods to eat, but rather when you should eat them.\n\nThere are several different intermittent fasting methods, all of which split the day or week into eating periods and fasting periods.\n\nFast for 16 hours each day, for example by only eating between noon and 8pm.\n\nStudies show that intermittent fasting can cause weight loss, reduce the risk of Type 2 diabetes, cancer and inflammation and is beneficial for heart health etc.";
      default:
        return '';
    }
  }

  Map<String, List<String>> get getGuidelines {
    switch (name) {
      case 'Vegetarian':
        return {
          "A few healthy foods to eat on a vegetarian diet are:": [
            "Fruits: Apples, bananas, berries, oranges, melons, pears, peaches",
            "Vegetables: Leafy greens, asparagus, broccoli, tomatoes, carrots",
            "Grains: Quinoa, barley, buckwheat, rice, oats",
            "Legumes: Lentils, beans, peas, chickpeas.",
            "Nuts: Almonds, walnuts, cashews, chestnuts",
            "Seeds: Flaxseeds, chia and hemp seeds",
            "Healthy fats: Coconut oil, olive oil, avocados",
            "Proteins: Tempeh, tofu, seitan, natto, nutritional yeast, spirulina, dairy products"
          ],
          "Depending on your needs and preferences, you may have to avoid the following foods on a vegetarian diet:":
              [
            "Meat: Beef, veal and pork",
            "Poultry: Chicken and turkey",
            "Fish and shellfish: This restriction does not apply to pescetarians.",
            "Meat-based ingredients: Gelatin, lard, carmine, isinglass, oleic acid and suet",
            "Eggs: This restriction applies to vegans and lacto-vegetarians.",
            "Dairy products: This restriction on milk, yogurt and cheese applies to vegans and ovo-vegetarians.",
            "Other animal products: Vegans may choose to avoid honey, beeswax and pollen."
          ]
        };
      case 'Low Carb':
        return {
          "You should avoid these six food groups and nutrients, in order of importance:":
              [
            "Sugar: Soft drinks, processed fruit juices, agave, candy, ice cream and many other products that contain added sugar",
            "Refined grains: Wheat, rice, barley and rye, as well as bread, cereal and pasta",
            "Trans fats: Hydrogenated or partially hydrogenated oils",
            "Diet and low-fat products: Many dairy products, cereals or crackers are fat-reduced, but contain added sugar",
            "Highly processed foods: If it looks like it was made in a factory, don’t eat it",
            "Starchy vegetables: It’s best to limit starchy vegetables in your diet if you’re following a very low-carb diet"
          ],
          "You should base your diet on these real, unprocessed, low-carb foods":
              [
            "Meat: Beef, lamb, pork, chicken and others; grass-fed is best",
            "Fish: Salmon, trout, haddock and many others; wild-caught fish is best",
            "Eggs: Omega-3-enriched or pastured eggs are best",
            "Vegetables: Spinach, broccoli, cauliflower, carrots and many others",
            "Fruits: Apples, oranges, pears, blueberries, strawberries",
            "Nuts and seeds: Almonds, walnuts, sunflower seeds, etc",
            "High-fat dairy: Cheese, butter, heavy cream, yogurt",
            "Fats and oils: Coconut oil, butter, lard, olive oil and fish oil"
          ]
        };
      case 'Mediterranean':
        return {
          "Foods to eat:": [
            "Vegetables: Tomatoes, broccoli, kale, spinach, onions, cauliflower, carrots, brussels sprouts, cucumbers, etc.",
            "Fruits: Apples, bananas, oranges, pears, strawberries, grapes, dates, figs, melons, peaches, etc.",
            "Nuts and seeds: Almonds, walnuts, macadamia nuts, hazelnuts, cashews, sunflower seeds, pumpkin seeds, etc.",
            "Legumes: Beans, peas, lentils, pulses, peanuts, chickpeas, etc.",
            "Tubers: Potatoes, sweet potatoes, turnips, yams, etc.",
            "Whole grains: Whole oats, brown rice, rye, barley, corn, buckwheat, whole wheat, whole-grain bread and pasta.",
            "Fish and seafood: Salmon, sardines, trout, tuna, mackerel, shrimp, oysters, clams, crab, mussels, etc.",
            "Poultry: Chicken, duck, turkey, etc.",
            "Eggs: Chicken, quail and duck eggs.",
            "Dairy: Eat in moderation. Cheese, yogurt, Greek yogurt, etc.",
            "Herbs and spices: Garlic, basil, mint, rosemary, sage, nutmeg, cinnamon, pepper, etc.",
            "Healthy Fats: Extra virgin olive oil, olives, avocados and avocado oil."
          ],
          "Foods to avoid:": [
            "Foods with added sugar: Soda, candies, ice cream, table sugar and many others.",
            "Refined grains: White bread, pasta made with refined wheat, etc.",
            "Trans fats: Found in margarine and various processed foods.",
            "Refined oils: Soybean oil, canola oil, cottonseed oil and others.",
            "Processed meat: Processed sausages, hot dogs, etc.",
            "Highly processed foods: Anything labeled “low-fat” or “diet” or which looks like it was made in a factory."
          ]
        };
      case 'Keto':
        return {
          "Foods to Eat": [
            "Meat: Red meat, steak, ham, sausage, bacon, chicken, and turkey",
            "Fatty fish: Salmon, trout, tuna, and mackerel",
            "Eggs: Pastured or omega-3 whole eggs",
            "Butter and cream: Grass-fed butter and heavy cream",
            "Cheese: Unprocessed cheeses like cheddar, goat, cream, blue, or mozzarella",
            "Nuts and seeds: Almonds, walnuts, flaxseeds, pumpkin seeds, chia seeds, etc.",
            "Healthy oils: Extra virgin olive oil, coconut oil, and avocado oil",
            "Avocados: Whole avocados or freshly made guacamole",
            "Low carb veggies: Green veggies, tomatoes, onions, peppers, etc.",
            "Condiments: Salt, pepper, herbs, and spices"
          ],
          "Foods to Avoid": [
            "Sugary foods: Soda, fruit juice, smoothies, cake, ice cream, candy, etc",
            "Grains or Starches: Wheat-based products, rice, pasta, cereal, etc",
            "Fruit: All fruit, except small portions of berries like strawberries",
            "Beans or Legumes: Peas, kidney beans, lentils, chickpeas, etc",
            "Root vegetables and tubers: Potatoes, sweet potatoes, carrots, parsnips, etc",
            "Low fat or diet products: Low fat mayonnaise, salad dressings, and condiments",
            "Some condiments or sauces: Barbecue sauce, honey mustard, teriyaki sauce, ketchup, etc",
            "Unhealthy fats: Processed vegetable oils, mayonnaise, etc",
            "Alcohol: Beer, cocktails and other high-carb alcohol drinks ",
            "Sugar-free diet foods: Sugar-free candies, syrups, puddings, sweeteners, desserts, etc"
          ]
        };
      case 'Diabetes Friendly':
        return {
          "Dietary Guidelines": [
            "Drink green tea/ chamomile tea twice a day",
            "Avoid use of sugar in tea, milk/coffee, or any hot/cold beverage, use artificial sweetener instead.",
            "Limit quantity of table sugar/honey/jaggery to 10gm (2Tsp)/day.",
            "Cook and refrigerate potato/rice/pasta before use, this will prevent absorption of carbohydrates. Limit the use to 2 serving (90g) a day.",
            "Avoid products made of refined flour.",
            "Instead of white bread and polished rice, eat multigrain bread and brown rice.  ",
            "Include more green leafy vegetables in the diet. Consume those at least twice/week. ",
            "Eat fruits every alternate day. Include more citrus fruits.",
            "Drink skim milk 200ml/day. Incase of lactose intolerance, have soy milk or almond milk.",
            "Consume 1tsp fenugreek seeds and 1tsp flax seeds daily.",
            "Use virgin oils (virgin olive oil, virgin coconut oil) instead of refined oil.",
            "Walk for a minimum 30 minutes daily. Do a 10 minute walk or activity post meals.",
            "Practice meditation for 15 minutes to 30 minutes daily."
          ]
        };
      case 'DASH':
        return {
          "Some guidelines for following the DASH diet:": [
            "Whole Grains: Eat 6-8 servings (1 serving= 40g cooked) of whole grains like whole wheat, brown rice, bulgur, quinoa, oatmeal, multigrain breads and whole-grain cereals daily.",
            "Vegetables: Eat 4-5 servings (1 serving= 30g to 45g) of all kinds of vegetables daily. ",
            "Fruits: 4-5servings (1 serving= 30g to 45g). Examples of fruits you can eat include apples, pears, peaches, berries and tropical fruits like pineapple and mango.",
            "Dairy: 2-3 servings/day (1 serving= 200ml/g). Dairy products on the DASH diet should be low in fat. Examples include skim milk and low-fat cheese and yogurt.",
            "Meat: 6 or fewer servings a week (1 serving= 25g). Choose lean cuts of meat and try to eat a serving of red meat only occasionally — no more than once or twice a week.",
            "Nuts, seeds and legumes: 4-5 servings/week (1 serving= 20g). These include almonds, peanuts, hazelnuts, walnuts, sunflower seeds, flaxseeds, kidney beans, lentils and split peas",
            "Sweets: Less than 5 servings per week (1 serving= 15g). Added sugars are kept to a minimum on the DASH diet, so limit your intake of candy, soda and table sugar. The DASH diet also restricts unrefined sugars and alternative sugar sources, like agave nectar.",
            "Sodium intake: 2300mg/ day."
          ]
        };
      case 'Paleo':
        return {
          "Foods to Eat on the Paleo Diet": [
            "Meat: All types of meat",
            "Fish and seafood: Salmon, trout, haddock, shrimp, shellfish, etc. Choose wild-caught if you can.",
            "Eggs: Choose free-range, pastured or omega-3 enriched eggs.",
            "Vegetables: Broccoli, kale, peppers, onions, carrots, tomatoes, etc.",
            "Fruits: Apples, bananas, oranges, pears, avocados, strawberries, blueberries and more.",
            "Tubers: Potatoes, sweet potatoes, yams, turnips, etc.",
            "Nuts and seeds: Almonds, macadamia nuts, walnuts, hazelnuts, sunflower seeds, pumpkin seeds and more.",
            "Healthy fats and oils: Extra virgin olive oil, coconut oil, avocado oil and others.",
            "Salt and spices: Sea salt, garlic, turmeric, rosemary, etc."
          ],
          "Foods to Avoid on the Paleo Diet": [
            "High sugar foods: Soft drinks, fruit juices, table sugar, high-fructose corn syrup, candy, pastries, ice cream.",
            "Grains: Includes breads and pastas, wheat, spelt, rye, barley, etc.",
            "Legumes: All types of legumes",
            "Dairy: Avoid most dairy, especially low-fat (some versions of paleo do include full-fat dairy like butter and cheese).",
            "Some vegetable oils: Soybean oil, sunflower oil, cottonseed oil, corn oil, grapeseed oil, safflower oil and others.",
            "Trans fats: Found in margarine and various processed foods. Usually referred to as “hydrogenated” or “partially hydrogenated” oils.",
            "Artificial sweeteners: Aspartame, sucralose, cyclamates, saccharin, acesulfame potassium. Use natural sweeteners instead."
          ]
        };
      case 'Vegan':
        return {
          "Foods to Eat": [
            "Tofu, tempeh and seitan: These provide a versatile protein-rich alternative to meat, fish, poultry and eggs in many recipes.",
            "Legumes: Foods such as beans, lentils and peas are excellent sources of many nutrients and beneficial plant compounds. Sprouting, fermenting and proper cooking can increase nutrient absorption.",
            "Nuts and nut butters: Especially unblanched and unroasted varieties, which are good sources of iron, fiber, magnesium, zinc, selenium and vitamin E.",
            "Seeds: Especially hemp, chia and flax seeds, which contain a good amount of protein and beneficial omega-3 fatty acids.",
            "Calcium-fortified plant milks and yogurts: These help vegans achieve their recommended dietary calcium intakes. Opt for varieties also fortified with vitamins B12 and D whenever possible.",
            "Algae: Spirulina and chlorella are good sources of complete protein. Other varieties are great sources of iodine.",
            "Nutritional yeast: This is an easy way to increase the protein content of vegan dishes and add an interesting cheesy flavor. Pick vitamin B12-fortified varieties whenever possible.",
            "Whole grains, cereals and pseudocereals: These are a great source of complex carbs, fiber, iron, B-vitamins and several minerals. Spelt, teff, amaranth and quinoa are especially high-protein option",
            "Sprouted and fermented plant foods: Ezekiel bread, tempeh, miso, natto, sauerkraut, pickles, kimchi and kombucha often contain probiotics and vitamin K2. Sprouting and fermenting can also help improve mineral absorption.",
            "Fruits and vegetables: Both are great foods to increase your nutrient intake. Leafy greens such as bok choy, spinach, kale, watercress and mustard greens are particularly high in iron and calcium."
          ],
          "Foods to Avoid": [
            "Meat and poultry: All animal meat like beef, lamb, pork, veal, horse, organ meat, wild meat, chicken, turkey, goose, duck, quail, etc.",
            "Fish and seafood: All types of fish, anchovies, shrimp, squid, scallops, calamari, mussels, crab, lobster, etc.",
            "Dairy: Milk, yogurt, cheese, butter, cream, ice cream, etc.",
            "Eggs: From chickens, quails, ostriches, fish, etc.",
            "Bee products: Honey, bee pollen, royal jelly, etc.",
            "Animal-based ingredients: Whey, casein, lactose, egg white albumen, gelatin, cochineal or carmine, isinglass, shellac, L-cysteine, animal-derived vitamin D3 and fish-derived omega-3 fatty acids."
          ]
        };
      case 'High Protein':
        return {
          "Here are a few basic guidelines for following a high-protein diet:":
              [
            "Keep a food diary: Once MealGuide calculates your calorie needs, you can then decide your daily protein needs",
            "Calculate protein needs: To calculate your protein needs, multiply your weight in pounds by 0.6–0.75 grams, or your weight in kilograms by 1.2–1.6 grams",
            "Eat at least 25–30 grams of protein at meals: Consuming a minimum of 25 grams of protein at meals may promote weight loss, muscle maintenance and better overall health",
            "Include both animal and plant proteins in your diet: Eating a combination of both types helps make your diet more nutritious overall, eg - egg and tofu salad",
            "Choose high-quality protein sources: Focus on fresh meats, eggs, dairy and other proteins, rather than processed meats like bacon and lunch meats",
            "Consume well-balanced meals: Balance high-protein foods with vegetables, fruits and other plant foods at every meal"
          ],
          "Tips on increasing your protein intake:": [
            "Snack on cheese (Parmesan, swiss, gouda and mozzarella etc)",
            "Replace cereal with eggs",
            "Top your food with chopped almonds",
            "Snack on dry fruits when hungry",
            "Choose greek yogurt",
            "Add protein to your salad",
            "Drink a protein shake daily",
            "Munch on edamame ",
            "Enjoy canned fish",
            "Eat cottage cheese whenever you feel like",
            "Have peanut butter with fruit on toast"
          ]
        };
      case 'Balanced Diet':
        return {
          "A healthy, balanced diet will usually include the following nutrients:":
              [
            "vitamins, minerals, and antioxidants",
            "carbohydrates, including starches and fiber",
            "protein",
            "healthy fats"
          ],
          "A balanced diet will include a variety of foods from the following groups:":
              ["fruits", "vegetables", "grains", "dairy", "protein foods"],
          "Foods to avoid or limit on a healthy diet include:": [
            "highly processed foods",
            "refined grains",
            "added sugar and salt",
            "red and processed meat",
            "alcohol",
            "trans fats"
          ]
        };
      case 'PCOD':
        return {
          "Foods recommended for PCOS:": [
            "High-fiber foods can help combat insulin resistance by slowing down digestion and reducing the impact of sugar on the blood. This is beneficial to women with PCOS.",
            "Lean protein sources like tofu, chicken, and fish don’t provide fiber but are very filling and a healthy dietary option for women with PCOS."
          ],
          "Great options for high-fiber foods include:": [
            "Cruciferous vegetables such as broccoli, cauliflower, and brussels sprouts etc",
            "Greens vegetables including red leaf lettuce and arugula etc",
            "Green and red peppers",
            "Beans and lentils",
            "Almonds",
            "Berries",
            "Sweet potatoes",
            "Winter squash",
            "Pumpkin"
          ],
          "Foods that help reduce inflammation will also be beneficial. They include:":
              [
            "Tomatoes",
            "Kale",
            "Spinach",
            "Almonds and walnuts",
            "Olive oil",
            "Fruits, such as blueberries and strawberries",
            "Fatty fish high in omega-3 fatty acids, such as salmon and sardines"
          ],
          "Foods to avoid:": [
            "Refined carbohydrates, such as mass-produced pastries and white bread",
            "Fried foods, such as fast food",
            "Sugary beverages, such as sodas and energy drinks",
            "Processed meats, such as hot dogs, sausages, and luncheon meats",
            "Solid fats, including margarine, shortening, and lard",
            "Excess red meat, such as steaks, hamburgers, and pork"
          ]
        };
      case 'Gluten Free':
        return {
          "Following ingredients are the main sources of gluten in any diet:": [
            "Wheat-based foods like wheat bran, wheat flour, spelt, durum, kamut and semolina",
            "Barley",
            "Rye",
            "Triticale",
            "Malt",
            "Brewer’s yeast"
          ],
          "Below are some foods that may have ingredients containing gluten added to them. Avoid these foods:":
              [
            "Bread: All wheat-based bread",
            "Pasta: All wheat-based pasta",
            "Cereals: Unless labeled gluten-free",
            "Baked goods: Cakes, cookies, muffins, pizza, bread crumbs and pastries",
            "Snack foods: Candy, muesli bars, crackers, pre-packaged convenience foods, roasted nuts, flavored chips and popcorn, pretzels",
            "Sauces: Soy sauce, teriyaki sauce, hoisin sauce, marinades, salad dressings",
            "Beverages: Beer, flavored alcoholic beverages",
            "Other foods: Couscous, broth (unless labeled gluten-free)."
          ],
          "The following foods are naturally gluten-free:": [
            "Meats and fish: All meats and fish, except battered or coated meats",
            "Eggs: All types of eggs are naturally gluten-free",
            "Dairy: Plain dairy products, such as plain milk, plain yogurt and cheeses. However, flavored dairy products may have added ingredients that contain gluten, so you will need to read the food labels.",
            "Fruits and vegetables: All fruits and vegetables are naturally free of gluten",
            "Grains: Quinoa, rice, buckwheat, tapioca, sorghum, corn, millet, amaranth, arrowroot, teff and oats (if labeled gluten-free)",
            "Starches and flours: Potatoes, potato flour, corn, corn flour, chickpea flour, soy flour, almond meal/flour, coconut flour and tapioca flour",
            "Nuts and seeds: All nuts and seeds",
            "Spreads and oils: All vegetable oils and butter",
            "Herbs and spices: All herbs and spices",
            "Beverages: Most beverages, except for beer (unless labeled as gluten-free)"
          ]
        };
      case 'Intermittent Fasting':
        return {
          "Dietary Guidelines": [
            "Restrict food consumption and drinking of calorie-containing beverages to a set window of 8 hours per day.",
            "Eat a balanced diet comprising fruits, vegetables, whole grains, healthy fats, and protein to maximize the potential health benefits of this diet.",
            "Avoid food and beverages containing calories during the fasting period.",
            "Can drink only water and green tea during the fasting period.",
            "Exercise for a minimum of 30 minutes daily.",
            "Meditate for 15 minutes daily.",
            "Restrict high sugar, processed and deep fried foods in meals.",
            "Replace sugar with artificial sweetener wherever possible.",
            "Restrict use of table sugar/jaggery/honey/sugar syrups to less than 2tsp (10g) per day.",
            "Include 1 green leafy vegetable (30g) in your meal daily.",
            "Restrict use of avocados, cassava and refined flour."
          ]
        };
      default:
        return {};
    }
  }
}
