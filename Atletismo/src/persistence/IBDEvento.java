package persistence;

import java.util.List;

import model.Atleta;
import model.Pais;
import model.Prova;
import model.Record;
import model.Resultado;
import model.ResultadoEvento;

public interface IBDEvento {

	String novoAtleta(Atleta atleta); 
	String novoResultadoEvento(Resultado resultado);
	List<Prova> recebeProva();
	List<Pais> recebeListaPaises();
	List<ResultadoEvento> recebeResultadoEvento(Resultado resultado);
	List<Record> recebeRecords(int id);
}
