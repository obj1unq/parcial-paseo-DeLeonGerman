// Nota 2 (dos)
//Test: no test
//1) Mal, si bien hay una aceptable división de responsabilidades en la jerarquía de Prenda, 
//   Es un error muy grave que se modifique el estado interno del objeto ante una pregunta.
//   No es por capricho, si no que cada vez que le preguntas la comodidad, la comodidad aumenta!
//   Funcionalmente responde correctamente solo la primera vez.
//   También hay otros bugs menores, como que al sobreescribir nivel de Desgaste se pierde el máximo
//2) Mal: No solo tiene un bug en la resolución de la funcionalidad, si no que NO LANZA EL ERROR cuando se le 
// pide intercambiar pares incompatibles. 
// 3) Mal: Prenda Par define un método distinto para el abrigo en lugar de la usada en la superclase
//, Prenda liviana no tiene sobrescrito el comportamiento de ninguna manera
// 4) M No está el punto de inicio del requerimiento, hay métodos perdidos en los niños, con código duplicado y pobre delegación
// 5) Regular: Mucho código duplicado, hay que buscar sobreescribir solo lo que no sirva
// 6) No lo hace
// 7) Bien: Problemas de delegación 
// 8) No lo hace


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
	var abrigo //TODO: Esta variable no la necesitan todoas las subclases (solo las PEsadas)
	var desgaste //TODO: Esta variable no la necesitan todas las subclases
	var nivelDeComodidad = 0	//TODO: Esto debería ser una variable local al metodo
	var talle
	method nivelDeComodidad(ninio)	
	{
		//TODO En esta "pregunta" estás modificando estado interno del objeto
		//Entonces cada vez que le preguntas nivelDeComodidad está incrementando el valor
		//y siempre contestas distinto: cada vez más comodo. 
		//Esto debería resolverse con variables locales
		if(ninio.talle() == talle)
		{
			nivelDeComodidad += 8
		}
		nivelDeComodidad -= self.nivelDeDesgaste()
		return nivelDeComodidad
	}
	method nivelDeDesgaste()
	{
		//TODO: deberias usar self.fesgaste(), ya que no todas las subclases usan la variable para
		//saber el desgaste
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
		//TODO: enviar mensajes en lugar de usar las variables, porque las subclases sobreescriben
		return abrigo + nivelDeComodidad
	}
}
class PrendaPar inherits Prenda
{
	//TODO: Esto tiene nombre de "número" aunque parece que lo usas como objetos prenda
	var desgasteDerecho
	var desgasteIzquierdo
	
	override method nivelDeDesgaste()
	{	
		//TODO: Al sobreescribir este método, perdiste el máximo de 3
		//deberías haber sobrescrito solo desgaste	
		return (desgasteDerecho.desgaste() + desgasteIzquierdo.desgaste()) /2
	}
	override method nivelDeComodidad(ninio)
	{
		//TODO: incorrecto el uso de una variable de instancia para esto.
		//lo correcto sería que no altere variables de instancia 
		//y revuelva:  return super() - if(ninio.esPeque()) 1 else 0
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
			//TODO: Perdiste la referencia al derecho actual
			//Cuando hagas par.serIntercambiado le va a poner la referencia que ya tiene 			
			desgasteDerecho = par.desgasteDerecho()
			par.serIntercambiado(self)
		}
		//TODO: SI no puede tiene que lanzar error
	}
	method serIntercambiado(par)
	{
	   desgasteDerecho = par.desgasteDerecho()
	}
	method desgasteDerecho()
	{
		return desgasteDerecho
	}
	//TODO: No está sobreescribiendo nada! toda la jerarquía debería trasbajar sobre el mismo mensaje
	method nivelDeAbrigo()
	{
		return desgasteIzquierdo.abrigo() + desgasteDerecho.abrigo()
	}
}
//TODO: Estas clases no apoprtan nada. Y heredás comportamiento
//que no se usa
class PrendaIzquierda inherits Prenda
{

}
class PrendaDerecha inherits Prenda
{
	
}
class RopaLiviana inherits Prenda
{
	//NO! si se desgastas las prendas Livianas!
	//El comportamiento de la superclase estaba razonablemente bien
	override method nivelDeDesgaste()
	{
		return 0
	}
	override method nivelDeComodidad(ninio)
	{
		//TODO: Incorrecto la modificacion de variables de 
		//isntancia par resolver
		//una pregunta
		nivelDeComodidad += 2
		return super(ninio)
	}
}
class RopaPesada inherits Prenda
{
	//NO! si se desgastas las prendas Pesadas!
	//El comportamiento de la superclase estaba razonablemente 
	//además duplica el método que en Liviana
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
	
	//TODO: Duplica codigo entre ambos métodos. No queda claro a cual hay que llamar para cumplir
	//el requerimiento 4. 
	method listoParaPaseo()
	{
		return prendas.size() >= 5	&& self.calidadPrendasPromedio() > 8
	}
	method nivelDeAbrigoAceptable()
	{
		//TODO: Delegar mejor: prendas.any({prenda => prenda.esAbrigada()})
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
	//TODO repite mucho codigo de la superclase
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
		//Duplica codigo al no delegar en el ninio el saber si es pequenio o no
		hijos.filter({unHijo => unHijo.edad() < 4})
	}
}