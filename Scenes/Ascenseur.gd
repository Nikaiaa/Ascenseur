extends Area3D

var temps_total
@export var temps_trajet : Timer
@export var temps_etage : Timer
@export var timer_bouton : Timer
var etage_actuel
var temps_depuis_le_dernier_etage
# Called when the node enters the scene tree for the first time.
func _ready():
	temps_trajet.start()
	temps_etage.start()
	etage_actuel = 1
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _timeOut_etage():
	etage_actuel= etage_actuel+1
	
func _on_environment_button_pressed():
	var nouvel_etage = 4 #étage où on veut aller
#	var temps_parcouru = 150 - temps_trajet.time_left 
#	print(temps_parcouru)
	var etage_restant
	etage_restant = nouvel_etage-etage_actuel #nombre étage à parcourir
	var temps_restant = etage_restant * 30 #nombre boucle de 30s à parcourir
	#lorsque qu'un nouveau bouton est appuyé
	temps_depuis_le_dernier_etage = 30 - temps_etage.time_left #temps qu'on a parcouru depuis dernier checkpoint d'étage
	var temps_a_parcourir = temps_restant - temps_depuis_le_dernier_etage 
	timer_bouton.start(temps_a_parcourir)
	

func timeOut_Timer_Boutton():
	print("ptn les portes sont ouvertes")
