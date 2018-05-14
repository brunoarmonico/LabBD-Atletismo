package controller;

import java.util.List;

import model.Atleta;
import model.Prova;
import persistence.DBEvento;

public class ControlaEvento {
	private DBEvento bd = new DBEvento();

	public String adicionarAtleta(Atleta atleta) {
		return bd.novoAtleta(atleta);
	}
	
	public List<Prova> listarProvas(){
		return bd.recebeProva();
	}
}
