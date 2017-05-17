#					landlord_first_incounter__dialog.gd
extends Node

var dialog = {

				'Titel'						:"landlord the fist encounter",
				'Actors'					:["landlord","player"],
				'End_callback_functions'	:[],
				'Export_Spanish_Word_List'	:{},
				'Audio_Enabled'				:true,

#					THE_CONVERSATION

			['A',1]:{'actor':0,		'sentens':"Hola",													'audio_pos'	:{'start':01.25,		'stop':02.09},	'spanish_words':['hola']	},
			['A',2]:{'actor':0,		'sentens':"How are you?",									'audio_pos'	:{'start':03.37,		'stop':04.02},	},
			['A',3]:{'actor':0,		'sentens':"Do you like your new home?",		'audio_pos'	:{'start':04.78,		'stop':06.28},	},
			['A',4]:{'actor':1,		'sentens':"Yes",													'audio_pos'	:{'start':07.57,		'stop':08.08},	},

			['A',5]:{'actor':0,		'sentens':"I'll be expecting you to pay the 75 dineros at the start of every month",	'audio_pos'	:{'start':11.39,		'stop':18.66}, 'wait_time':07.27,	'spanish_words':['dinero']	},
			['A',6]:{'wait_time':3,	'callback_functions':['ask_for_rent']	},

			['A',7]:{'actor':0,		'sentens':"I have to go. Adiós",					'audio_pos'	:{'start':04.78,		'stop':06.28},		'spanish_words':['adiós'],		 'callback_functions':['end_conversation']},






#					SPANISH_WORDS

'Spanish_Words':{
					'dinero':{
								'translation'	:{1:'money',},
								'is_processed'	:false,
								'grammer_group'	:'INTERJECTION',
							},
					'hola'	:{
								'translation'	:{1:'hello',2:'hi'},
								'is_processed'	:false,
								'grammer_group'	:'INTERJECTION',
							},
					'adiós'	:{
								'translation'	:{1:'goodbye ',2:'bye'},
								'is_processed'	:false,
								'grammer_group'	:'NOUN',
								'gender'		:'M',
							},
				},


#					CALLBACK_FUNCTIONS

'Callback_Functions':{
						'ask_for_rent'		:{
											'args'			:[75],
											'owner'			:0,
											'execution_time':'start_of_action',
											},

						'end_conversation'	:{
											'args'			:["test"],
											'owner'			:0,
											'execution_time':'end_of_action',
											},
					}





}
