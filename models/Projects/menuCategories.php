$menuCategories["Projects"] = [
"type" => "submenu",
"id" => "Projects",
"full" => $translation->translateLabel('Projects'),
"short" => "Pr",
"data" => [

[
"id" => "Projects/ProjectTypes",
"full" => $translation->translateLabel('Project Types'),
"href"=> "Projects/ProjectTypes",
"short" => "Pr"
],
[
"id" => "Projects/Projects",
"full" => $translation->translateLabel('Projects'),
"href"=> "Projects/Projects",
"short" => "Pr"
]
]
];
