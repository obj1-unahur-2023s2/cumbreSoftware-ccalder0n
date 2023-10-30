import conocimientos.*
import participante.*

object cumbre
{
	const auspiciantes = #{}
	const participantes = #{}
	const registrados = #{}
	var cantidadDeCommitsMin = 300
	
	method cantidadDeCommitsMin(nuevo){ cantidadDeCommitsMin = nuevo }
	method auspiciantes(){ return auspiciantes }
	method registrarParticipante(participante){ registrados.add(participante) }
	method ingresarParticipante(participante)
	{
		if(self.puedeIngresar(participante))
		{ participantes.add(participante) }
		else
		{ self.error("no cumple requisitos de registro minimo!") }
	}
	method puedeIngresar(participante)
	{ 
		return participante.conocimientos().contains(programacionBasica) and self.cumpleRequisitos(participante) and not self.tieneRestringidoAcceso(participante)
	}
	method cumpleRequisitos(participante)
	{
		return
		if(participante.esProgramador())
		{ participante.cantidadDeCommitsPublicos() == cantidadDeCommitsMin } 
		else
		{ participante.cantidadDeCommitsPublicos() == (cantidadDeCommitsMin - 100) and participante.conocimientos().contains(objetos)}
	}
	method tieneRestringidoAcceso(participante)
	{ 
		return participante.nacionalidad().esConflictivo() and not self.cumpleCuotaPorPais(participante)
	}
	method cumpleCuotaPorPais(participante)
	{ 
		return if(auspiciantes.contains(participante.nacionalidad()))
		{ true }
		else
		{ self.cantidadDeParticipantesDe(participante.nacionalidad()) <= 2 }
	}
	
	method paisesParticipantes(){ return participantes.map({ p => p.nacionalidad() }).asSet() }
	method cantidadDeParticipantesDe(pais){ return participantes.count({ p => p.nacionalidad() == pais }) }
	method paisConMasParticipantes(){ return self.paisesParticipantes().max({ p => self.cantidadDeParticipantesDe(p) }) }
	method paisesExtranjeros(){ return self.paisesParticipantes().removeAll(auspiciantes) }
	method esRelevante(){ return participantes.all({ p => p.esCape() }) }
	
	method esSegura(){ return registrados.all({ p => self.puedeIngresar(p) }) }
}
