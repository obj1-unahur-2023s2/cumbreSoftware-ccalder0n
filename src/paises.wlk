import cumbre.*


class Pais
{
	const paisesEnConflicto = #{}
	
	method registrarConflicto(pais)
	{ 
		paisesEnConflicto.add(pais)
		pais.registrarConflicto(self)
	}
	method esConflictivo(){ return paisesEnConflicto.intersection(cumbre.auspiciantes()).size() > 0 }
}