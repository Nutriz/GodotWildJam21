{
	"output_characters": {
		"B1": "Josiane",
		"B2": "na",
		"B3": "na",
		"B4": "na",
		"B5": "na",
		"B6": "pompier"
	},
	"story_introduction_fr": [
		"Vous ête Bernadette, une jeune femme de 20 ans qui vient de trouver un emploi dans les telecommunications. Vous allez relier relier les correspondants appellant aux destinataire. Ce qui en 1922 est un assez bon job. Ceci est votre premier jour et vous êtes inexpérimentée, mais après tout, ça ne doit pas être bien compliqué comme job"
	],
	"story_introduction_en": [
		"TODO"
	],
	"boss_dialogue_fr": [
		"Bonjour Bernadette, heureux de vous avoir dans notre équipe, au sein de La Gaule Connectée",
		"J'espère que votre premier jour de travail se passera bien",
		"Votre travail consiste à prendre le jack rouge et le brancher dans une des entrée quand il y a un appel",
		"Après avoir écoute la personne, il faut la mettre en attente avec le bouton du milieu",
		"Ensuite vous devez connecter le jack bleu à l'interlocuteur souhaité",
		"Pour finir, il ne vous reste plus qu'à désactiver la mise en attente",
		"La conversation défile sous vos yeux, mais vous n'avez pas le droit de la lire, La Gaule Connectée respect les conversations privées",
		"Oups j'ai une urgence à régler, essayer de faire au mieux en attendant",
		"Bonne chance",
		"A oui j'oubliai, parfois le technicien fait des bourdes..."
	],
	"boss_dialogue_en": [
		"TODO"
	],
	"tech_man_fr": [
		{
			"text_fr": "Oula je crois que je me suis encore trompé. Ah non ouf, c'est bon, tout roule !",
			"text_en": "TODO",
			"change_count": 0
		},
		{
			"text_fr": "euh, désolé Bernadette, mais il y a eu un problème, j'ai du échanger l'entrée $A avec l'entrée $B",
			"text_en": "TODO",
			"change_count": 1
		},
		{
			"text_fr": "Oups, dans ma tête c'était pas claire, l'entrée $A échangé avec l'entrée $B. Et $C échangé avec l'entrée $D",
			"text_en": "TODO",
			"change_count": 2
		}
	],
	"tech_man_en": [
		"TODO"
	],
	"main_story": {
		"dial1": [
			{
				"name": "Henri",
				"pos": "caller",
				"text_fr": "Bonjour, je dois absolument parler à Josiane, c'est très important.",
				"text_en": ""
			},
			{
				"name": "Henri",
				"pos": "caller",
				"text_fr": "Pouvez-vous me mettre en relation avec elle ?",
				"text_en": "",
				"holding": true
			},
			{
				"B1": [
					{
						"name": "Josiane",
						"pos": "called",
						"text_fr": "Allo ?",
						"text_en": ""
					},
					{
						"name": "Henri",
						"pos": "caller",
						"text_fr": "Bonjour Josiane, c'est Henri. Nous nous sommes rencontré à montmartre la semaine dernière !",
						"text_en": ""
					},
					{
						"name": "Josiane",
						"pos": "called",
						"text_fr": "Ah oui Henri. Bonjour.",
						"text_en": ""
					},
					{
						"name": "Josiane",
						"pos": "called",
						"text_fr": "Attendez il faut que je vous laissez, rappelez moi.",
						"text_en": ""
					}
				],
				"B2": [
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Oui ?",
						"text_en": ""
					},
					{
						"name": "Henri",
						"pos": "caller",
						"text_fr": "Bonjour Josiane, c'est Henri.",
						"text_en": ""
					},
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Vous faites erreur, moi c'est B2",
						"text_en": ""
					}
				],
				"B3": [
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Oui ?",
						"text_en": ""
					},
					{
						"name": "Henri",
						"pos": "caller",
						"text_fr": "Bonjour Josiane, c'est Henri.",
						"text_en": ""
					},
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Vous faites erreur, moi c'est B2",
						"text_en": ""
					}
				],
				"B4": [
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Oui ?",
						"text_en": ""
					},
					{
						"name": "Henri",
						"pos": "caller",
						"text_fr": "Bonjour Josiane, c'est Henri.",
						"text_en": ""
					},
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Vous faites erreur, moi c'est B2",
						"text_en": ""
					}
				],
				"B5": [
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Oui ?",
						"text_en": ""
					},
					{
						"name": "Henri",
						"pos": "caller",
						"text_fr": "Bonjour Josiane, c'est Henri.",
						"text_en": ""
					},
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Vous faites erreur, moi c'est B2",
						"text_en": ""
					}
				],
				"B6": [
					{
						"name": "Pompier",
						"pos": "called",
						"text_fr": "Oui ?",
						"text_en": ""
					},
					{
						"name": "Henri",
						"pos": "caller",
						"text_fr": "Bonjour Josiane, c'est Henri.",
						"text_en": ""
					},
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Vous faites erreur, moi c'est B2",
						"text_en": ""
					}
				]
			}
		],
		"dial2": [
			{
				"name": "Henri",
				"pos": "caller",
				"text_fr": "Il faut ABSOLUMENT que je reparle à Josiane",
				"text_en": "",
				"holding": true
			},
			{
				"B1": [
					{
						"name": "Josiane",
						"pos": "called",
						"text_fr": "Bonjour.",
						"text_en": ""
					},
					{
						"name": "Henri",
						"pos": "caller",
						"text_fr": "Bonjour Josiane, enfin !",
						"text_en": ""
					}
				],
				"B2": [
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Vous êtes qui ?",
						"text_en": ""
					},
					{
						"name": "Henri",
						"pos": "caller",
						"text_fr": "Je suis Henri",
						"text_en": ""
					},
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Je ne connais pas de Henri, bye.",
						"text_en": ""
					}
				]
			}
		]
	},
	"secondary_stories": {
		"dial1": [
			{
				"name": "Barman",
				"pos": "caller",
				"text_fr": "Bonjour, c'est pour une commande de bières",
				"text_en": "",
				"holding": true
			},
			{
				"B1": [
					{
						"name": "Josiane",
						"pos": "called",
						"text_fr": "J'adoreeee la météooooore",
						"text_en": ""
					}
				],
				"B2": [
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Désolé monsieur je ne suis pas la personne qu'il vous faut",
						"text_en": ""
					}
				],
				"B3": [
					{
						"name": "George",
						"pos": "called",
						"text_fr": "... ... ... ......",
						"text_en": ""
					}
				],
				"B4": [
					{
						"name": "Alphonse",
						"pos": "called",
						"text_fr": "Hip...je dis ouip !",
						"text_en": ""
					}
				],
				"B5": [
					{
						"name": "Chef",
						"pos": "called",
						"text_fr": "Moi je fais le manger, pas le boisson",
						"text_en": ""
					}
				],
				"B6": [
					{
						"name": "Pompier",
						"pos": "called",
						"text_fr": "Moi je fais le manger, pas le boisson",
						"text_en": ""
					}
				]
			}
		],
		"dial2": [
			{
				"name": "Tintin",
				"pos": "caller",
				"text_fr": "On va sur la lune !!!",
				"text_en": "",
				"holding": true
			},
			{
				"B1": [
					{
						"name": "B1",
						"pos": "called",
						"text_fr": "Tonnerre de Brest  !",
						"text_en": ""
					}
				],
				"B2": [
					{
						"name": "B2",
						"pos": "called",
						"text_fr": "Tonnerre de Brest  !",
						"text_en": ""
					}
				],
				"B3": [
					{
						"name": "B3",
						"pos": "called",
						"text_fr": "Tonnerre de Brest  !",
						"text_en": ""
					}
				],
				"B4": [
					{
						"name": "B4",
						"pos": "called",
						"text_fr": "Tonnerre de Brest  !",
						"text_en": ""
					}
				],
				"B5": [
					{
						"name": "B5",
						"pos": "called",
						"text_fr": "Tonnerre de Brest  !",
						"text_en": ""
					}
				],
				"B6": [
					{
						"name": "Pompier",
						"pos": "called",
						"text_fr": "Tonnerre de Brest  !",
						"text_en": ""
					}
				]
			}
		]
	}
}
