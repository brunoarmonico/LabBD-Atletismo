package controller;

import java.util.List;

import model.Atleta;
import model.Pais;
import model.Prova;
import model.Record;
import model.Resultado;
import model.ResultadoEvento;
import persistence.DBEvento;

public class ControlaEvento {
	private DBEvento bd = new DBEvento();

	public String adicionarAtleta(Atleta atleta) {
		return bd.novoAtleta(atleta);
	}
	
	public List<Prova> listarProvas(){
		return bd.recebeProva();
	}
	
	public String adicionarResultado(Resultado resultado) {
		return bd.novoResultadoEvento(resultado);
	}
	
	public List<Pais> recebePaises() {
		return bd.recebeListaPaises();
	}
	
	public List<ResultadoEvento> listarResultados(Resultado resultado){
		return bd.recebeResultadoEvento(resultado);
	}
	
	public List<Record> listarRecordes (int id){
		return bd.recebeRecords(id);
	}
}
