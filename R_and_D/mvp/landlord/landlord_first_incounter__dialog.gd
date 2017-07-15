#					landlord_first_incounter_dialog.gd
extends Node

var dialog = {

				'Titel'						:"landlord the fist encounter",
				'Actors'					:["landlord","player"],
				'End_callback_functions'	:[],
#				'Export_Spanish_Word_List'	:{},
				'Audio_Enabled'				:false,

#					THE_CONVERSATION

			['A',1]:{'actor':0,		'sentens':"Hola",							'audio_pos'	:{'start':01.25,	'stop':02.09},	'spanish_words':['hola']	},
			['A',2]:{'actor':0,		'sentens':"How are you?",					'audio_pos'	:{'start':03.37,	'stop':04.02},	},
			['A',3]:{'actor':0,		'sentens':"Do you like your new home?",		'audio_pos'	:{'start':04.78,	'stop':06.28},	},
			['A',4]:{'actor':1,		'sentens':"Yes",							'audio_pos'	:{'start':07.57,	'stop':08.08},	},
			['A',5]:{'actor':0,		'sentens':"Bien, bien!",					'audio_pos'	:{'start':07.57,	'stop':08.08},	'spanish_words':['bien']	},

			['A',5]:{'actor':0,		'sentens':"I'll be expecting you to pay the 75 dineros at the start of every month",	'audio_pos'	:{'start':11.39,'stop':18.66},	'spanish_words':['dinero'],		'callback_functions':['ask_for_rent'],	'wait_time':7,	},
			
			['A',6]:{'actor':0,		'sentens':"I understand that you are looking for work"},
			['A',7]:{'actor':1,		'sentens':"that's right",},
			['A',8]:{'actor':0,		'sentens':"well, you might find some trabajo down by the docs",		'spanish_words':['trabajo']	},
			['A',9]:{'actor':0,		'sentens':"mhmm...",		'wait_time':1},
			['A',10]:{'actor':0,	'sentens':"You will probably need to learn better español to get more stedy work though",		'wait_time':7},
			['A',11]:{'actor':0,	'sentens':"You do want to learn espanish right"	},
			['A',12]:{'actor':1,	'sentens':"Yes ofcorse",	},
			['A',13]:{'actor':0,	'sentens':"Then here is a house warming present for you",		'callback_functions':['activate_notepad'],	'wait_time':7,	},
			
			
			['A',14]:{'actor':0,	'sentens':"I have to go. Adiós",			'audio_pos'	:{'start':04.78,		'stop':06.28},		'spanish_words':['adiós'],		 'callback_functions':['end_conversation']},






#					SPANISH_WORDS

#'Spanish_Words':{
#					'dinero':{
#								'word'				:'dinero',
#								'translation'		:{1:'money',},
#								'grammer_group'		:'INTERJECTION',
#								'special_status'	:null,
#								
								'is_processed'		:false,
								'dates'				:{'data_of_discovery':null},
								'progress'			:null,
								'mnemoics'			:{},
#							},
#					'hola'	:{
#								'word'				:'hola',
#								'translation'		:{1:'hello',2:'hi'},
#								'grammer_group'		:'INTERJECTION',
#							},
#					'adiós'	:{
#								'word'				:'adiós',
#								'translation'		:{1:'goodbye ',2:'bye'},
#								'grammer_group'		:'NOUN',
#								'gender'			:'M',
#							},
#					'trabajo'	:{
#								'word'				:'trabajo',
#								'translation'		:{1:'work ',2:'job'},
#								'grammer_group'		:'NOUN',
#								'gender'			:'M',
#							},
#				},


#					CALLBACK_FUNCTIONS

'Callback_Functions':{
						'ask_for_rent'		:{
											'owner'			:0,
											'execution_time':'start_of_action',
											'times_executed':0,
											'args'			:{'rent_sum':-75,'dealay_time':1.5},
											},

						'activate_notepad'	:{
											'owner'			:0,
											'execution_time':'end_of_action',
											'times_executed':0,
											},

						'end_conversation'	:{
											'args'			:["test"],
											'owner'			:0,
											'execution_time':'end_of_action',
											'times_executed':0,
											},
					}





}
