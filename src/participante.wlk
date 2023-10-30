import conocimientos.*
import paises.*
import cumbre.*

class Participante
{
	const nacionalidad
	const conocimientos
	var cantidadDeCommitsPublicos
	
	method cantidadDeCommitsPublicos(){ return cantidadDeCommitsPublicos }
	method nacionalidad(){ return nacionalidad }
	method conocimientos(){ return conocimientos.asSet() }
	method esCape()
	method cumpleRequisitosDeAcceso()
}

class Programador inherits Participante
{
	override method esCape(){ return cantidadDeCommitsPublicos > 500 }
	method esProgramador(){ return true }
	override method cumpleRequisitosDeAcceso(){ return cumbre.puedeIngresar(self) }
}

class Especialista inherits Participante
{
	override method esCape(){ return conocimientos.size() > 2 }
	method esProgramador(){ return false }
	override method cumpleRequisitosDeAcceso(){ return cumbre.puedeIngresar(self) }
}