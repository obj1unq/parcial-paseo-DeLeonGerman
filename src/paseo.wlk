
//Objetos usados para los talles
object xs {
}

object s {
}
object m {
	
}
object l{
	
}
object xl{
	
}

class Prenda
{
	var abrigo
	var desgaste
	var nivelDeComodidad = 0	
	var talle
	method nivelDeComodidad(ninio)	
	{
		if(ninio.talle() == talle)
		{
			nivelDeComodidad += 8
		}
		nivelDeComodidad -= self.nivelDeDesgaste()
		return nivelDeComodidad
	}
	method nivelDeDesgaste()
	{
		return 3.min(desgaste)
	}
	method desgaste()
	{
		return desgaste
	}
	method abrigo()
	{
		return abrigo
	}
	method nivelCalidad()
	{
		return abrigo + nivelDeComodidad
	}
}
class PrendaPar inherits Prenda
{
	var desgasteDerecho
	var desgasteIzquierdo
	
	override method nivelDeDesgaste()
	{		
		return (desgasteDerecho.desgaste() + desgasteIzquierdo.desgaste()) /2
	}
	override method nivelDeComodidad(ninio)
	{
		if(ninio.edad() < 4)
		{
			nivelDeComodidad -= 1
		}
		return super(ninio)
	}
	method prendaDerecha(prendaDerecha)
	{
	  		desgasteDerecho = prendaDerecha
	}
	method prendaIzquierda(prendaIzquierda)
	{
		desgasteIzquierdo = prendaIzquierda
	}
	method intercambiar(par)
	{
		if(par.talle() == talle){
			desgasteDerecho = par.desgasteDerecho()
			par.serIntercambiado(self)
		}
	}
	method serIntercambiado(par)
	{
	   desgasteDerecho = par.desgasteDerecho()
	}
	method desgasteDerecho()
	{
		return desgasteDerecho
	}
	method nivelDeAbrigo()
	{
		return desgasteIzquierdo.abrigo() + desgasteDerecho.abrigo()
	}
}
class PrendaIzquierda inherits Prenda
{

}
class PrendaDerecha inherits Prenda
{
	
}
class RopaLiviana inherits Prenda
{
	override method nivelDeDesgaste()
	{
		return 0
	}
	override method nivelDeComodidad(ninio)
	{
		nivelDeComodidad += 2
		return super(ninio)
	}
}
class RopaPesada inherits Prenda
{
	override method nivelDeDesgaste()
	{
		return 0
	}
	
}
class Ninio
{
	var talle
	var edad
	var prendas
	method talle()
	{
		return talle
	}
	method talle(unTalle)
	{
		talle = unTalle
	}
	method edad()
	{
		return edad
	}
	method prendas()
	{
		return prendas
	}
	method listoParaPaseo()
	{
		return prendas.size() >= 5	&& self.calidadPrendasPromedio() > 8
	}
	method nivelDeAbrigoAceptable()
	{
		return prendas.size() >= 5 && prendas.map({unaPrenda => unaPrenda.abrigo()})
												. any({abrigo => abrigo >= 3})
		
																							
	}
	method calidadPrendasPromedio()
	{
		return prendas.map({unaPrenda => unaPrenda.nivelCalidad()})
						.sum()
						/prendas.size()
	}
}
class NinioProblematico inherits Ninio
{
	var juguete	
	override method listoParaPaseo()
	{
		return prendas.size() >= 4  && prendas.map({unaPrenda => unaPrenda.abrigo()})
												. any({abrigo => abrigo >= 3}) 
												 && self.jugueteAceptable()	
	}
	method jugueteAceptable()
	{
		return edad.between(juguete.edadMinima() , juguete.edadMaxima())
	}
	method juguete(unJuguete)
		{
			juguete = unJuguete
		}
}
class Juguete{
	var edadMinima
	var edadMaxima
	
	method edadMinima()
	{
		return edadMinima
	}
	method edadMaxima()
	{
		return edadMaxima
	}
}
class Familia
{
	var hijos
	
	method chiquitos()
	{
		hijos.filter({unHijo => unHijo.edad() < 4})
	}
}