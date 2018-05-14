package persistence;

import java.util.List;

import model.Atleta;
import model.Prova;
import model.Resultado;

public interface IBDEvento {

	String novoAtleta(Atleta atleta); 
	String novoResultadoEvento(Resultado resultado);
	List<Prova> recebeProva();
}
