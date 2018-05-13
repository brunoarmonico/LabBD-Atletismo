package persistence;

import model.Atleta;
import model.Resultado;

public interface IBDEvento {

	String novoAtleta(Atleta atleta); 
	String novoResultadoEvento(Resultado resultado);
}
