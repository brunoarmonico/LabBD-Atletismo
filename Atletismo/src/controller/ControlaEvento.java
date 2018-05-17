package controller;

import java.util.List;

import model.Atleta;
import model.Pais;
import model.Prova;
import model.Resultado;
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
}
